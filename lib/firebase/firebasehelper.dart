import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agromate/screens/dashboard.dart';
class Service {
  //here all firebase auth
  final auth = FirebaseAuth.instance;

  void createUser(context, email, password) async {
    //fun to create user
    try {
      await auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()))
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  void loginUser(context, email, password) async {
    //fun for user login
    try {
      await auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()))
              });
    } catch (e) {
      errorBox(context, e);
    }
  }

  void signOut(context) async {
    //fun to signout
    try {
      await auth.signOut(
        
      );
    } catch (e) {
      errorBox(context, e);
    }
  }

  void errorBox(context, e) {
    //fun to display error
    showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            title: const Text("ERROR"),
            content: Text(e.toString()),
          );
        });
  }
}
