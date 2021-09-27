import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_task/Bloc/UserInformationCubit.dart';
import 'package:weather_task/Bloc/UsersAuthCubit.dart';
import 'package:weather_task/Screens/SplashScreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    'Something Wrong',
                    style: TextStyle(color: Colors.red, fontSize: 30),
                  ),
                ),
              ),
            );
          }
          return MultiBlocProvider(providers: [
            BlocProvider(create: (_)=>UsersAuthCubit()),
            BlocProvider(create:(_) => UserInformationCubit()..getUserInformation()),
          ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplachScreen(),
            ),
          );
        });
  }
}
