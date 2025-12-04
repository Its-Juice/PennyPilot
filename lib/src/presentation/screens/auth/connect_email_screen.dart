import 'package:flutter/material.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/dashboard_screen.dart';

class ConnectEmailScreen extends StatelessWidget {
  const ConnectEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Accounts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Link your email to automatically track expenses.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _ConnectButton(
              icon: Icons.mail,
              label: 'Connect Gmail',
              color: Colors.red.shade700,
              onPressed: () {
                // TODO: Implement Gmail OAuth
              },
            ),
            const SizedBox(height: 16),
            _ConnectButton(
              icon: Icons.mail_outline,
              label: 'Connect Outlook',
              color: Colors.blue.shade700,
              onPressed: () {
                // TODO: Implement Outlook OAuth
              },
            ),
            const SizedBox(height: 16),
            _ConnectButton(
              icon: Icons.cloud,
              label: 'Connect iCloud',
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
              child: const Text('Try Demo Mode (Mock Data)'),
            ),
            const SizedBox(height: 16),
            Text(
              'We only read emails related to receipts and subscriptions. No data leaves your device.',
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
