import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
      ),
      body: ListView(
        children: [
          // Calendar View Placeholder
          Container(
            height: 300,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: const Center(child: Text('Calendar View Placeholder')),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Active Subscriptions'),
          ),
          // List
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Spotify'),
            subtitle: const Text('Renews on Dec 15'),
            trailing: const Text('\$9.99'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Netflix'),
            subtitle: const Text('Renews on Dec 20'),
            trailing: const Text('\$15.99'),
          ),
        ],
      ),
    );
  }
}
