import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:overlay_support/overlay_support.dart';
import 'package:agromate/screens/notificationservice.dart'; // Make sure this exists

class MoistureStatus extends StatefulWidget {
  const MoistureStatus({super.key});

  @override
  _MoistureStatusState createState() => _MoistureStatusState();
}

class _MoistureStatusState extends State<MoistureStatus> {
  final dbRef = FirebaseDatabase.instance.ref('moisture/latest');
  int? moistureValue;
  String? moistureStatus;
  String? weatherCondition;
  String? recommendation;

  String? _previousStatus;

  final String apiKey = '15fd111ed24cfa866995f2cfa44d33fc';
  final String city = 'Rawalpindi';

  @override
  void initState() {
    super.initState();
    listenToRealtimeUpdates();
  }

  void listenToRealtimeUpdates() {
    dbRef.onValue.listen((event) async {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        final newStatus = data['status']?.toString();
        final newValue = data['value'];

        // Check for status change
        if (_previousStatus != null && _previousStatus != newStatus) {
          String message = "Soil status changed to $newStatus";

          // Show top-up notification
          showSimpleNotification(
            Text(message),
            background: Colors.green,
            duration: const Duration(seconds: 3),
          );

          // Save to notification service
          NotificationService().addNotification(message);
        }

        // Save current status for next comparison
        _previousStatus = newStatus;
if(!mounted) return;
        setState(() {
          moistureValue = newValue;
          moistureStatus = newStatus;
        });

        await fetchWeatherAndRecommend();
      }
    });
  }

  Future<void> fetchWeatherAndRecommend() async {
    final url = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        print('API Error: ${response.statusCode}');
        return;
      }

      final data = json.decode(response.body);

      // Debug output
      print('Weather API response: $data');

      if (data == null || data['list'] == null || data['list'] is! List) {
        print('Forecast data is invalid or missing.');
        return;
      }

      final forecastList = data['list'] as List;

      final now = DateTime.now();
      bool rainExpected = false;

      for (var entry in forecastList) {
        final forecastTime = DateTime.parse(entry['dt_txt']);
        final diff = forecastTime.difference(now);

        if (diff.inHours <= 72) {
          final weatherList = entry['weather'] as List?;
          if (weatherList != null && weatherList.any((w) => w['main'].toString().toLowerCase().contains('rain'))) {
            rainExpected = true;
            break;
          }
        }
      }

      if (!mounted) return;
      setState(() {
        weatherCondition = rainExpected ? 'Rain expected (next 3 days)' : 'No rain expected';
        recommendation = generateRecommendation(moistureStatus, rainExpected);
      });
    } catch (e) {
      print('Weather API error: $e');
    }
  }



  String generateRecommendation(String? status, bool rainComing) {
    if (status == null) return 'No data';
    if (status == 'Dry' && !rainComing) return 'Irrigate the soil';
    if (status == 'Dry' && rainComing) return 'No irrigation needed (rain expected)';
    if (status == 'Too Wet') return 'Do not irrigate (soil is too wet)';
    return rainComing ? 'Irrigation optional (rain expected)' : 'Monitor regularly';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Moisture Advisor'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoTile(title: 'Moisture Value', value: '$moistureValue'),
              InfoTile(title: 'Moisture Status', value: moistureStatus),
              InfoTile(title: 'Weather Forecast', value: weatherCondition),
              InfoTile(title: 'Recommendation', value: recommendation),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String? value;

  const InfoTile({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        tileColor: Colors.green.shade100,
        title: Text(title),
        subtitle: Text(value ?? 'Loading...'),
        shape: Border.all(color: Colors.green),
      ),
    );
  }
}
