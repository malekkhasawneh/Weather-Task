import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_task/Screens/HomeScreen.dart';
import 'package:weather_task/Screens/LoginScreen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapShot) {
          if (userSnapShot.data == null) {
            return LoginScreen();
          } else if (userSnapShot.hasData) {
            return HomePage();
          }
          return Center(
            child: Text(
              'Something Wrong',
              style: TextStyle(fontSize: 40),
            ),
          );
        });
  }
}
