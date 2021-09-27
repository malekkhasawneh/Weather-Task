import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_task/Bloc/UserAuthClasses.dart';
import 'package:weather_task/Bloc/UsersAuthCubit.dart';
import 'package:weather_task/Screens/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> showMyDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Take Picture'),
            actions: [
              ListTile(
                title: Text('From Gallery'),
                onTap: () {
                  UsersAuthCubit.get(context).getFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('From Camera'),
                onTap: () {
                  UsersAuthCubit.get(context).getFromCamera();
                  Navigator.pop(context);
                },
              ),
            ],
            scrollable: true,
          );
        });
  }

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
              'Register',
              style: TextStyle(color: Colors.purple),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.25), // border color
                        shape: BoxShape.circle,
                      ),
                      child: UsersAuthCubit.get(context).imageFile == null
                          ? CircleAvatar(
                              backgroundImage:
                                  Image.asset('images/userLogo.png').image)
                          : CircleAvatar(
                              backgroundImage: Image.file(
                                File(UsersAuthCubit.get(context)
                                    .imageFile!
                                    .path),
                                width: 300,
                                height: 300,
                                errorBuilder: (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) {
                                  return Icon(
                                    Icons.image,
                                    size: 45,
                                  );
                                },
                              ).image,
                            ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showMyDialog(context);
                      },
                      icon: Icon(
                        Icons.image,
                        color: Colors.purple,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "First Name",
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
                      controller: lastName,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Last Name",
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
                      controller: password,
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
                    padding: EdgeInsets.only(top: 15),
                    child: TextFormField(
                      validator: (input) {
                        if (input != password.text) {
                          return 'password does not match';
                        }
                        return null;
                      },
                      controller: rePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: "Re-Password",
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
                      controller: phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: "Phone",
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
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                          width: 170,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.purple),
                              onPressed: () {
                                if (UsersAuthCubit.get(context).imageFile !=
                                    null) {
                                  UsersAuthCubit.get(context).userRegister(
                                      userFirstName: firstName.text,
                                      userLastName: lastName.text,
                                      userEmail: email.text,
                                      userPassword: password.text,
                                      userPhone: phone.text);
                                  Fluttertoast.showToast(
                                      msg: 'Register Done Successfully',
                                      toastLength: Toast.LENGTH_LONG);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Choose Image',
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,gravity: ToastGravity.TOP);
                                }
                              },
                              child: Text('Register')))),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 25),
                    child: Row(
                      children: [
                        Text(
                          'You Have Account ? ',
                          style: TextStyle(color: Colors.purple),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              'Login',
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
        );
      },
    );
  }
}
