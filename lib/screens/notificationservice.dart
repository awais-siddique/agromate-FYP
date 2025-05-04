import 'package:flutter/material.dart';

class NotificationService with ChangeNotifier {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  NotificationService._internal();

  final List<Map<String, dynamic>> _notifications = [];

  List<Map<String, dynamic>> get notifications => List.unmodifiable(_notifications);

  void addNotification(String message) {
    final now = DateTime.now();
    _notifications.insert(0, {
      "icon": Icons.water_drop,
      "message": message,
      "date": "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}",
      "time": "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
      "checked": false,
    });
    
    notifyListeners();
  }

  void markAsChecked(int index, bool value) {
    _notifications[index]["checked"] = value;
    notifyListeners();
  }
  void deleteNotification(int index) {
  _notifications.removeAt(index);
  notifyListeners();
}

}
