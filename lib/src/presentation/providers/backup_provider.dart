import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/services/backup_service.dart';
import 'package:pennypilot/src/presentation/providers/database_provider.dart';

final backupServiceProvider = Provider<BackupService>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return BackupService(databaseService);
});
