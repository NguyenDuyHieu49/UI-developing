import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      "Alice liked your post",
      "Bob commented on your answer",
      "Your daily task is available",
      "Update your profile to get better suggestions",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t('notifications')),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView.separated(
            itemCount: notifications.length,
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: Text(notifications[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
