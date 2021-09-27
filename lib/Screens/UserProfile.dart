import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_task/Bloc/UserInformationClasses.dart';
import 'package:weather_task/Bloc/UserInformationCubit.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController email = TextEditingController();
    Future<void> showUpdatePhotoDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Take Picture'),
              actions: [
                ListTile(
                  title: Text('From Gallery'),
                  onTap: () {
                    UserInformationCubit.get(context).getFromGallery();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('From Camera'),
                  onTap: () {
                    UserInformationCubit.get(context).getFromCamera();
                    Navigator.pop(context);
                  },
                ),
              ],
              scrollable: true,
            );
          });
    }

    final _updateInfoFormKey = GlobalKey<FormState>();
    return BlocConsumer<UserInformationCubit, UserInformationClasses>(
        listener: (context, state) {},
        builder: (context, state) {
          var userInfo = UserInformationCubit.get(context).userInfo;
          firstName.text = userInfo.firstName.toString();
          lastName.text = userInfo.lastName.toString();
          email.text = userInfo.email.toString();
          phone.text = userInfo.phone.toString();

          return userInfo.firstName == null ? Scaffold(body: Center(child: CircularProgressIndicator(),),): Scaffold(
            appBar: AppBar(leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon:Icon(Icons.arrow_back_sharp,color: Colors.purple,)),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'User Profile',
                style: TextStyle(color: Colors.purple),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _updateInfoFormKey,
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
                        child: UserInformationCubit.get(context).imageFile ==
                                null
                            ? Container(
                              child: CircleAvatar(
                                  backgroundImage:
                                      Image.network(userInfo.userImageUrl.toString(),
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container( child: CircularProgressIndicator(),);
                                        },).image,),
                            )
                            : CircleAvatar(
                                backgroundImage: Image.file(
                                  File(UserInformationCubit.get(context)
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
                          showUpdatePhotoDialog(context);
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
                                  UserInformationCubit.get(context)
                                      .updateUserInfo(
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    email: email.text,
                                    phone: phone.text,
                                  );
                                  UserInformationCubit.get(context).getUserInformation();
                                  if (UserInformationCubit.get(context)
                                          .imageFile !=
                                      null)
                                    UserInformationCubit.get(context)
                                        .updateUserImage();
                                  Fluttertoast.showToast(msg: 'Information Updated Successfully',toastLength: Toast.LENGTH_LONG);
                                },
                                child: Text('Update')))),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
