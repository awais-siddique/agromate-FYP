import 'package:flutter/material.dart';

class SoilMonitoringScreen extends StatelessWidget {
  const SoilMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Monitoring'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon and title
            const Column(
              children: [
                Icon(
                  Icons.hail, // Replace with a relevant icon
                  size: 48,
                  color: Colors.brown,
                ),
                SizedBox(height: 8),
                Text(
                  'Soil Health',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Soil Health Information Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Moisture Header
                    const Row(
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: Colors.blue,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Moisture:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Table with Measured Ratio, Normal Ratio, and Date
                    Table(
                      border: TableBorder.all(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                        width: 1,
                      ),
                      children: const [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Measured Ratio',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Normal Ratio',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Date',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '34',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '50',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '26 Dec 24',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '17',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '40',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '24 Dec 24',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Recommendations Section
                    const Text(
                      'Recommendations:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Add 500mL water on a daily basis for two weeks.\n'
                      '• Monitor moisture level on a daily basis.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
