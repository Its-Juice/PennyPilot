import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/data/local/database_service.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

// Keep isarProvider for existing code, but make it use DatabaseService
final isarProvider = FutureProvider((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return dbService.db;
});
