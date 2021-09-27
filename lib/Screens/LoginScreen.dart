import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_task/Bloc/UserAuthClasses.dart';
import 'package:weather_task/Bloc/UsersAuthCubit.dart';
import 'package:weather_task/Screens/HomeScreen.dart';
import 'package:weather_task/Screens/RegisterScreen.dart';
import 'package:weather_task/Screens/UserProfile.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersAuthCubit, UsersAuthClasses>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Login',
              style: TextStyle(color: Colors.purple),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 130),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                            backgroundImage: Image.asset(
                          'images/itgLogo.jpg',
                        ).image),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        validator: (input) {
                          if (input!.isEmpty || !input.contains('@')) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        controller: email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: "Email",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        validator: (input) {
                          if (input!.isEmpty || input.length < 6) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                        controller: password,obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: "Password",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 20),
                      child: Container(width: 170,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.purple),
                            onPressed: () {
                              UsersAuthCubit.get(context).userLogin(
                                  userEmail: email.text,
                                  userPassword: password.text);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: Text('login')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15,bottom: 40),
                      child: Row(
                        children: [
                          Text(
                            'You Don\'t Have Account Yet ? ',
                            style: TextStyle(color: Colors.purple),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.green),
                              ))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
