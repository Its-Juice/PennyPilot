import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/core/theme/app_theme.dart';
import 'package:pennypilot/src/presentation/providers/theme_provider.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pennypilot/src/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/dashboard_screen.dart';

import 'package:pennypilot/src/presentation/widgets/biometric_gate.dart';

class PennyPilotApp extends ConsumerWidget {
  const PennyPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check onboarding status from persistent state
    final appState = ref.watch(appStateProvider);
    final hasCompletedOnboarding = appState.hasCompletedOnboarding;
    
    final themeState = ref.watch(themeModeProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'PennyPilot',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic, isOled: themeState.isOledMode),
          themeMode: themeState.mode,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: BiometricGate(
            child: hasCompletedOnboarding ? const DashboardScreen() : const OnboardingScreen(),
          ),
        );
      },
    );
  }
}
