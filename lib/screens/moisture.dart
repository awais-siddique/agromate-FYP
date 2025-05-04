import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoistureStatus extends StatefulWidget {
  @override
  _MoistureStatusState createState() => _MoistureStatusState();
}

class _MoistureStatusState extends State<MoistureStatus> {
  final dbRef = FirebaseDatabase.instance.ref('moisture/latest');
  int? moistureValue;
  String? moistureStatus;
  String? weatherCondition;
  String? recommendation;

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
        setState(() {
          moistureValue = data['value'];
          moistureStatus = data['status'];
        });
        await fetchWeatherAndRecommend();
      }
    });
  }

  Future<void> fetchWeatherAndRecommend() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      final hasRain = (data['weather'] as List)
          .any((w) => w['main'].toString().toLowerCase().contains('rain'));

      setState(() {
        weatherCondition = hasRain ? 'Rain expected' : 'No rain';
        recommendation = generateRecommendation(moistureStatus, hasRain);
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
        title: Text('Soil Moisture Advisor'),
        centerTitle: true,
        backgroundColor: Colors.green,),
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

  const InfoTile({required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
          tileColor: Colors.green.shade100,
          title: Text(title),
          subtitle: Text(value ?? 'Loading...'),
          shape: Border.all(color: Colors.green,),
        ),
      
      
    );
  }
}
