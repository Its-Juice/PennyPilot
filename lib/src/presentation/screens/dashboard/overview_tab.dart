import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  final bool isDemoMode;

  const OverviewTab({super.key, required this.isDemoMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PennyPilot'),
        actions: [
          if (isDemoMode)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Chip(
                label: Text('DEMO MODE'),
                visualDensity: VisualDensity.compact,
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Total Spend Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Total Spent',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$1,245.50',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Spending by Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // Placeholder for Pie Chart
            const SizedBox(
              height: 200,
              child: Center(child: Text('Pie Chart Placeholder')),
            ),
            const SizedBox(height: 24),
            Text(
              'Upcoming Subscriptions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            // List of upcoming subscriptions
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.movie)),
                  title: Text('Netflix'),
                  subtitle: Text('Renewing in ${index + 2} days'),
                  trailing: const Text('\$15.99'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
