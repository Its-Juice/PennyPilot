import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/app.dart';
import 'package:pennypilot/src/presentation/providers/theme_provider.dart';
import 'package:pennypilot/src/data/local/database_service.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // TODO: Implement background task handling
    debugPrint("Native called background task: $task");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Workmanager
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );

  // Initialize Database
  final dbService = DatabaseService();
  final isar = await dbService.db;
  final prefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      isarProvider.overrideWithValue(isar),
    ],
  );

  // Initialize all services (Merchant Rules, Categories, LLM, etc.)
  await container.read(startupServiceProvider).initializeApp();

  runApp(UncontrolledProviderScope(
    container: container,
    child: const PennyPilotApp(),
  ));
}
