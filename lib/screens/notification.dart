import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agromate/screens/notificationservice.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationService>(
      builder: (context, notifier, child) {
        final notifications = notifier.notifications;

        return Scaffold(
         
          body: notifications.isEmpty
              ? const Center(child: Text("No notifications yet."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    return NotificationTile(
                      icon: n["icon"],
                      message: n["message"],
                      date: n["date"],
                      time: n["time"],
                      checked: n["checked"],
                      onChanged: (value) async {
  if (value == true) {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Notification"),
        content: const Text("Are you sure you want to delete this notification?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      notifier.deleteNotification(index);
    }
  }
},

                    );
                  },
                ),
        );
      },
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String message;
  final String date;
  final String time;
  final bool checked;
  final ValueChanged<bool?> onChanged;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.message,
    required this.date,
    required this.time,
    required this.checked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.shade100,
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 10),
                    Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Checkbox(
            value: checked,
            activeColor: Colors.green,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
