import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start a Timer to navigate to Login Screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      
      // Ensure the context is valid and routes are properly registered
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:const  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Image(
                image: AssetImage('assets/images/logo.png'), // Ensure this asset exists
                height: 250,
                width: 250,
              ),
              Text("Innovative Agriculture Assistant",style: TextStyle(fontFamily: 'poppins'),),
              SizedBox(height: 20),
           
           
            ],
          ),
        ),
      ),
    );
  }
}
