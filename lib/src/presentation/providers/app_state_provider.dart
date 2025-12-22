import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pennypilot/src/presentation/providers/theme_provider.dart';
import 'package:intl/intl.dart';

/// Manages application-level state (onboarding, app version, etc.)
/// Separate from auth state and financial data state
class AppStateNotifier extends StateNotifier<AppState> {
  final SharedPreferences prefs;

  AppStateNotifier(this.prefs) : super(_initialState(prefs));

  static AppState _initialState(SharedPreferences prefs) {
    return AppState(
      hasCompletedOnboarding: prefs.getBool('hasCompletedOnboarding') ?? false,
      lastAppVersion: prefs.getString('lastAppVersion'),
      currencyCode: prefs.getString('currencyCode') ?? 'USD',
      firstLaunchDate: prefs.getString('firstLaunchDate') != null
          ? DateTime.parse(prefs.getString('firstLaunchDate')!)
          : null,
    );
  }

  /// Update currency
  Future<void> setCurrency(String code) async {
    await prefs.setString('currencyCode', code);
    state = state.copyWith(currencyCode: code);
  }

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    await prefs.setBool('hasCompletedOnboarding', true);
    
    // Record first launch date if not already set
    if (state.firstLaunchDate == null) {
      final now = DateTime.now().toIso8601String();
      await prefs.setString('firstLaunchDate', now);
      state = state.copyWith(
        hasCompletedOnboarding: true,
        firstLaunchDate: DateTime.parse(now),
      );
    } else {
      state = state.copyWith(hasCompletedOnboarding: true);
    }
  }

  /// Reset onboarding (for factory reset)
  Future<void> resetOnboarding() async {
    await prefs.setBool('hasCompletedOnboarding', false);
    state = state.copyWith(hasCompletedOnboarding: false);
  }

  /// Update app version (for migration tracking)
  Future<void> updateAppVersion(String version) async {
    await prefs.setString('lastAppVersion', version);
    state = state.copyWith(lastAppVersion: version);
  }

  /// Factory reset - clears all app state
  Future<void> factoryResetAppState() async {
    await prefs.remove('hasCompletedOnboarding');
    await prefs.remove('lastAppVersion');
    await prefs.remove('firstLaunchDate');
    await prefs.remove('currencyCode');
    
    state = const AppState(
      hasCompletedOnboarding: false,
      lastAppVersion: null,
      firstLaunchDate: null,
      currencyCode: 'USD',
    );
  }
}

/// Immutable state for app-level settings
class AppState {
  final bool hasCompletedOnboarding;
  final String? lastAppVersion;
  final DateTime? firstLaunchDate;
  final String currencyCode;

  const AppState({
    required this.hasCompletedOnboarding,
    this.lastAppVersion,
    this.firstLaunchDate,
    this.currencyCode = 'USD',
  });

  AppState copyWith({
    bool? hasCompletedOnboarding,
    String? lastAppVersion,
    DateTime? firstLaunchDate,
    String? currencyCode,
  }) {
    return AppState(
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
      lastAppVersion: lastAppVersion ?? this.lastAppVersion,
      firstLaunchDate: firstLaunchDate ?? this.firstLaunchDate,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }
}

class CurrencyInfo {
  final String code;
  final String name;
  final String symbol;

  const CurrencyInfo(this.code, this.name, this.symbol);

  static String getSymbol(String code) {
    try {
      return popularCurrencies
          .firstWhere((c) => c.code == code.toUpperCase())
          .symbol;
    } catch (_) {
      // Try to get from system if not in popular list
      try {
        return NumberFormat.simpleCurrency(name: code).currencySymbol;
      } catch (e) {
        return code.toUpperCase();
      }
    }
  }
}

const List<CurrencyInfo> popularCurrencies = [
  CurrencyInfo('USD', 'US Dollar', r'$'),
  CurrencyInfo('EUR', 'Euro', '€'),
  CurrencyInfo('JPY', 'Japanese Yen', '¥'),
  CurrencyInfo('GBP', 'British Pound', '£'),
  CurrencyInfo('AUD', 'Australian Dollar', r'A$'),
  CurrencyInfo('CAD', 'Canadian Dollar', r'C$'),
  CurrencyInfo('CHF', 'Swiss Franc', 'CHF'),
  CurrencyInfo('CNY', 'Chinese Yuan', '¥'),
  CurrencyInfo('HKD', 'Hong Kong Dollar', r'HK$'),
  CurrencyInfo('NZD', 'New Zealand Dollar', r'NZ$'),
  CurrencyInfo('SEK', 'Swedish Krona', 'kr'),
  CurrencyInfo('KRW', 'South Korean Won', '₩'),
  CurrencyInfo('SGD', 'Singapore Dollar', r'S$'),
  CurrencyInfo('NOK', 'Norwegian Krone', 'kr'),
  CurrencyInfo('MXN', 'Mexican Peso', r'$'),
  CurrencyInfo('INR', 'Indian Rupee', '₹'),
  CurrencyInfo('RUB', 'Russian Ruble', '₽'),
  CurrencyInfo('ZAR', 'South African Rand', 'R'),
  CurrencyInfo('TRY', 'Turkish Lira', '₺'),
  CurrencyInfo('BRL', 'Brazilian Real', 'R\$'),
];

/// Global provider for app state
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AppStateNotifier(prefs);
});
