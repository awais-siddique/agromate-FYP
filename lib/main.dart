import 'package:agromate/screens/dashboard.dart';
import 'package:agromate/screens/forgotpassword.dart';
import 'package:agromate/screens/notificationservice.dart';
import 'package:agromate/screens/register.dart';
import 'package:agromate/screens/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';
import 'screens/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:FirebaseOptions(
        apiKey: "AIzaSyC-CkEn8aZOH5J_h_cCHVChphl4-8PYeZw",
        appId: "1:6181779788:android:c80f68c147a0c3cb92b7e9",
        messagingSenderId: "6181779788",
        projectId: "agromate-5604d",
      )
  );
  runApp(
    
       MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
      ],

      child: const MyApp(),)
    );
      

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return OverlaySupport.global(
      child: MaterialApp(
        themeMode: themeProvider.themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Agro Mate',
        // theme: ThemeData(
        //   primarySwatch: Colors.green,
        // ),
        // Initial route set to SplashScreen
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) =>  LoginScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/register':(context)=> const CreateAccountPage(),
          '/dashboard':(context)=> const DashboardScreen(),
        },
      ),
    );
  }
}
