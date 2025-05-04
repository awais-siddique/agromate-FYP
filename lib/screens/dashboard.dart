import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:agromate/screens/moisture.dart';
import 'package:flutter/material.dart';
import 'package:agromate/screens/notification.dart';
import 'package:agromate/screens/settings.dart';
import 'package:agromate/screens/recommendations.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
     DashboardContent(),
    const SettingsScreen(),
    const NotificationsScreen(),
  ];
  final List<String> _titles = [
    'Dashboard',
    'Settings',
    'Notifications',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _screens[_currentIndex], // Display content based on the selected index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if(!mounted) return;
          setState(() {
            _currentIndex = index;
          });
        
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Dashboard Content Widget
class DashboardContent extends StatefulWidget {
  DashboardContent({Key? key}) : super(key: key);

  @override
  _DashboardContentState createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final List<String> wheatImages = [
    'assets/images/wheat1.jpg',
    'assets/images/wheat2.jpg',
    'assets/images/wheat3.jpg',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Moisture data
  int? moistureValue;
  double moistureProgress = 0.0;

  @override
  void initState() {
    super.initState();
    startImageSlider();
    listenToMoistureData(); // Firebase moisture data
  }

  void startImageSlider() {
    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < wheatImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void listenToMoistureData() {
    final dbRef = FirebaseDatabase.instance.ref('moisture/latest');
    dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null && data['value'] != null) {
        final int value = data['value'] as int;
         int dryMax = 3360;     // Max value when soil is completely dry
         int wetMin = 1126;     // Min value when soil is fully wet
         final int clampedValue = value.clamp(wetMin, dryMax);
        final double percentage = ((dryMax - clampedValue) / (dryMax - wetMin)) * 100;
        if(!mounted) return;
        setState(() {
          moistureValue = value;
           moistureProgress = percentage / 100;
        }
        );
      }
    }
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: wheatImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      wheatImages[index],
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Soil Health Card with live data
          _buildCard(
            context,
            title: 'Soil Health',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Moisture'),
                    Text(
                      '${(moistureProgress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: moistureProgress,
                  color: Colors.green,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MoistureStatus()),
                    );
                  },
                  child: const Text(
                    'View Full Status',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tips Card
          _buildCard(
            context,
            title: 'Harvest Smarter – Agromate Tips',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: Icon(Icons.lightbulb_outline, color: Colors.green),
                  title: Text(
                    'Water early in the morning to reduce evaporation.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.lightbulb_outline, color: Colors.green),
                  title: Text(
                    'Use compost to improve soil fertility and structure.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.lightbulb_outline, color: Colors.green),
                  title: Text(
                    'Rotate crops yearly to maintain soil health and reduce pests.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.lightbulb_outline, color: Colors.green),
                  title: Text(
                    'Use mulch to retain soil moisture and suppress weed growth.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 10),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
