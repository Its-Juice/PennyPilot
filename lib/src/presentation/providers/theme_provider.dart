import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// State for theme management
class ThemeState {
  final ThemeMode mode;
  final bool isOledMode;

  ThemeState({required this.mode, this.isOledMode = false});

  ThemeState copyWith({ThemeMode? mode, bool? isOledMode}) {
    return ThemeState(
      mode: mode ?? this.mode,
      isOledMode: isOledMode ?? this.isOledMode,
    );
  }
}

// StateNotifier to manage ThemeMode and OLED preference
class ThemeModeNotifier extends StateNotifier<ThemeState> {
  final SharedPreferences prefs;

  ThemeModeNotifier(this.prefs) : super(_initialTheme(prefs));

  static ThemeState _initialTheme(SharedPreferences prefs) {
    final themeIndex = prefs.getInt('themeMode');
    final isOled = prefs.getBool('isOledMode') ?? false;
    final mode = themeIndex == null ? ThemeMode.system : ThemeMode.values[themeIndex];
    return ThemeState(mode: mode, isOledMode: isOled);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(mode: mode);
    await prefs.setInt('themeMode', mode.index);
  }

  Future<void> setOledMode(bool enabled) async {
    state = state.copyWith(isOledMode: enabled);
    await prefs.setBool('isOledMode', enabled);
  }
}

// Global provider for ThemeState
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeNotifier(prefs);
});
