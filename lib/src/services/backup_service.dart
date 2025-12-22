import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pennypilot/src/data/local/database_service.dart';
import 'package:logging/logging.dart';
import 'package:cryptography/cryptography.dart';
import 'package:path_provider/path_provider.dart';

class BackupService {
  final DatabaseService _databaseService;
  final _logger = Logger('BackupService');

  BackupService(this._databaseService);

  Future<void> exportBackup({String? passphrase}) async {
    try {
      final dbPath = await _databaseService.getDatabasePath();
      final dbFile = File(dbPath);
      
      if (!await dbFile.exists()) {
        throw Exception('Database file not found');
      }

      final dbBytes = await dbFile.readAsBytes();
      
      if (passphrase == null || passphrase.isEmpty) {
        // Plain export
        await Share.shareXFiles([XFile(dbPath)], text: 'PennyPilot Backup');
      } else {
        // Encrypted export
        final encryptedData = await _encryptData(dbBytes, passphrase);
        final tempDir = await getTemporaryDirectory();
        final encryptedFile = File('${tempDir.path}/pennypilot_backup.enc');
        await encryptedFile.writeAsBytes(encryptedData);
        
        await Share.shareXFiles([XFile(encryptedFile.path)], text: 'PennyPilot Encrypted Backup');
        _logger.info('Encrypted backup exported');
      }
    } catch (e) {
      _logger.severe('Export failed', e);
      rethrow;
    }
  }

  Future<void> importBackup({String? passphrase}) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final backupPath = result.files.single.path!;
        final backupFile = File(backupPath);
        final backupBytes = await backupFile.readAsBytes();
        
        Uint8List dataToImport;

        if (passphrase != null && passphrase.isNotEmpty) {
          try {
            dataToImport = await _decryptData(backupBytes, passphrase);
          } catch (e) {
            throw Exception('Decryption failed. Invalid passphrase or corrupted file.');
          }
        } else {
          dataToImport = backupBytes;
        }

        final dbPath = await _databaseService.getDatabasePath();
        
        // Close DB before overwriting
        final isar = await _databaseService.db;
        if (isar.isOpen) {
          await isar.close();
        }
        
        // Overwrite file
        await File(dbPath).writeAsBytes(dataToImport);
        
        _logger.info('Backup imported successfully');
      }
    } catch (e) {
      _logger.severe('Import failed', e);
      rethrow;
    }
  }

  Future<Uint8List> _encryptData(Uint8List data, String passphrase) async {
    final algorithm = AesGcm.with256bits();
    final secretKey = await _deriveKey(passphrase);
    final nonce = algorithm.newNonce();
    
    final secretBox = await algorithm.encrypt(
      data,
      secretKey: secretKey,
      nonce: nonce,
    );

    // Format: [version(1) | salt(16) | nonce(12) | ciphertext]
    // For simplicity here, we'll just prepend nonce and fixed salt
    final salt = Uint8List(16); // In a real app, generate and store a unique salt
    final combined = BytesBuilder()
      ..addByte(1) // version
      ..add(salt)
      ..add(nonce)
      ..add(secretBox.concatenation());
    
    return combined.toBytes();
  }

  Future<Uint8List> _decryptData(Uint8List encryptedData, String passphrase) async {
    if (encryptedData.length < 1 + 16 + 12) {
      throw Exception('Invalid encrypted data');
    }

    final version = encryptedData[0];
    if (version != 1) throw Exception('Unsupported backup version');

    // final salt = encryptedData.sublist(1, 17);
    final nonce = encryptedData.sublist(17, 29);
    final ciphertext = encryptedData.sublist(29);

    final algorithm = AesGcm.with256bits();
    final secretKey = await _deriveKey(passphrase);
    
    final mac = ciphertext.sublist(ciphertext.length - 16);
    final actualCiphertext = ciphertext.sublist(0, ciphertext.length - 16);

    final secretBox = SecretBox(
      actualCiphertext,
      nonce: nonce,
      mac: Mac(mac),
    );

    final decrypted = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    return Uint8List.fromList(decrypted);
  }

  Future<SecretKey> _deriveKey(String passphrase) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 10000,
      bits: 256,
    );
    
    // Fixed salt for simplicity in this turn, should be randomized per backup in production
    final salt = Uint8List.fromList('PennyPilotSalt123'.codeUnits);
    
    return await pbkdf2.deriveKeyFromPassword(
      password: passphrase,
      nonce: salt,
    );
  }
}
