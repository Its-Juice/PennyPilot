import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pennypilot/src/data/local/database_service.dart';
import 'package:logging/logging.dart';

class BackupService {
  final DatabaseService _databaseService;
  final _logger = Logger('BackupService');

  BackupService(this._databaseService);

  Future<void> exportBackup() async {
    try {
      final dbPath = await _databaseService.getDatabasePath();
      final file = File(dbPath);
      
      if (await file.exists()) {
        await Share.shareXFiles([XFile(dbPath)], text: 'PennyPilot Backup');
        _logger.info('Backup exported');
      } else {
        throw Exception('Database file not found');
      }
    } catch (e) {
      _logger.severe('Export failed', e);
      rethrow;
    }
  }

  Future<void> importBackup() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final backupPath = result.files.single.path!;
        final dbPath = await _databaseService.getDatabasePath();
        
        // Close DB before overwriting
        final isar = await _databaseService.db;
        await isar.close();
        
        // Overwrite file
        await File(backupPath).copy(dbPath);
        
        // Re-open DB (handled by app restart or re-init logic)
        // For now, we might need to force a restart or notify user
        _logger.info('Backup imported');
      }
    } catch (e) {
      _logger.severe('Import failed', e);
      rethrow;
    }
  }
}
