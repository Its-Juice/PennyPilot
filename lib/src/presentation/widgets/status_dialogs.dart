import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScanningDialog extends StatelessWidget {
  const ScanningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.network(
              'https://lottie.host/8e202511-2b62-4f38-bc0c-8433ecbc6f5b/vU6pYvIq4Z.json', // Premium scanning animation
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 24),
            Text(
              'Analyzing Your Inbox',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'We are locally scanning for receipts and identifying transactions with AI.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final int count;
  const SuccessDialog({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.network(
              'https://lottie.host/8040b2e8-569b-4379-9134-e3ac5e6f3649/v6k6q6p6Vv.json', // Success checkmark
              height: 150,
              width: 150,
              repeat: false,
            ),
            const SizedBox(height: 24),
            Text(
              'Scan Complete!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'We found $count new transactions for you.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('Awesome'),
            ),
          ],
        ),
      ),
    );
  }
}
