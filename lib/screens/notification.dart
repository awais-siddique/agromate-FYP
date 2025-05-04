import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example data for notifications
    final notifications = [
      {
        "icon": Icons.water_drop,
        "message": "Moisture declined by 20%",
        "date": "26-12-24",
        "time": "11:00",
        "checked": true,
      },
      {
        "icon": Icons.water_drop,
        "message": "Moisture declined by 20%",
        "date": "26-12-24",
        "time": "11:00",
        "checked": true,
      },
    ];

    return Scaffold(
      // Remove the AppBar here; it will inherit the parent navigation bar if used correctly
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(
            icon: notification["icon"] as IconData,
            message: notification["message"] as String,
            date: notification["date"] as String,
            time: notification["time"] as String,
            checked: notification["checked"] as bool,
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String message;
  final String date;
  final String time;
  final bool checked;

  const NotificationTile({
    Key? key,
    required this.icon,
    required this.message,
    required this.date,
    required this.time,
    required this.checked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 12),

          // Message and Date-Time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Checkbox
          Checkbox(
            value: checked,
            activeColor: Colors.purple,
            onChanged: (value) {
              // Handle checkbox state change if needed
            },
          ),
        ],
      ),
    );
  }
}
