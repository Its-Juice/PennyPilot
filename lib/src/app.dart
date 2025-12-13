import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/core/theme/app_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:pennypilot/src/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/dashboard_screen.dart';

class PennyPilotApp extends ConsumerWidget {
  const PennyPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Check if user is onboarded
    const bool isOnboarded = false; 

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'PennyPilot',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          themeMode: ThemeMode.system,
          home: isOnboarded ? const DashboardScreen() : const OnboardingScreen(),
        );
      },
    );
  }
}
