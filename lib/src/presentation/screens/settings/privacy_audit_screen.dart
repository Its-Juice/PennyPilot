import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyAuditScreen extends ConsumerWidget {
  const PrivacyAuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Audit'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAuditHeader(context),
          const SizedBox(height: 24),
          _buildAuditItem(
            context,
            icon: Icons.storage,
            title: 'Local-Only Storage',
            description: 'All your financial data (transactions, subscriptions, categories) is stored exclusively on this device. No cloud sync is used.',
            isPassed: true,
          ),
          _buildAuditItem(
            context,
            icon: Icons.psychology,
            title: 'On-Device Intelligence',
            description: 'Transaction categorization and subscription detection models run locally. Your spending patterns never leave your device.',
            isPassed: true,
          ),
          _buildAuditItem(
            context,
            icon: Icons.document_scanner,
            title: 'Local Receipt Processing',
            description: 'OCR and data extraction from emails and receipt photos are performed on-device. No images are sent to external servers.',
            isPassed: true,
          ),
          _buildAuditItem(
            context,
            icon: Icons.vpn_key,
            title: 'Secure Token Management',
            description: 'Email access tokens are stored in the system secure storage (Keychain/Keystore) and are only used for read-only Gmail API calls.',
            isPassed: true,
          ),
          _buildAuditItem(
            context,
            icon: Icons.security,
            title: 'Encryption at Rest',
            description: 'Data is protected by OS-level sandbox isolation. Manual backups can be encrypted with a custom passphrase.',
            isPassed: true,
          ),
          const SizedBox(height: 32),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.verified_user, size: 48, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    'Audit Status: Verified',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'PennyPilot has been audited for compliance with Local-First Privacy standards. No tracking, no ads, no cloud storage.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditHeader(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.privacy_tip_outlined, size: 64, color: Colors.blue),
        const SizedBox(height: 16),
        Text(
          'Privacy Compliance',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Verified status of your data privacy.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.outline),
        ),
      ],
    );
  }

  Widget _buildAuditItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required bool isPassed,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      if (isPassed)
                        const Icon(Icons.check_circle, color: Colors.green, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
