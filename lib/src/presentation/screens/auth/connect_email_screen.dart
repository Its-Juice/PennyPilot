import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/auth_provider.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectEmailScreen extends ConsumerWidget {
  const ConnectEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.connectAccounts),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.linkEmailDescription,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _ConnectButton(
              icon: Icons.mail,
              label: AppLocalizations.of(context)!.connectGmail,
              color: Colors.red.shade700,
              onPressed: () async {
                try {
                  final authService = ref.read(authServiceProvider);
                  final account = await authService.signInWithGoogle();
                  if (account != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.connectedTo(account))),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.failedToConnect(e.toString()))),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            _ConnectButton(
              icon: Icons.mail_outline,
              label: AppLocalizations.of(context)!.connectOutlook,
              color: Colors.blue.shade700,
              onPressed: () {
                // TODO: Implement Outlook OAuth
              },
            ),
            const SizedBox(height: 16),
            _ConnectButton(
              icon: Icons.cloud,
              label: AppLocalizations.of(context)!.connectICloud,
              color: Colors.blueGrey,
              onPressed: () {
                // TODO: Implement iCloud OAuth
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // Enable Mock Data Mode
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(isDemoMode: true),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.tryDemoMode),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.privacyDisclaimer,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ConnectButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
