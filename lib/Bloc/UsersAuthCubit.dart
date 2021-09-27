import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'UserAuthClasses.dart';

class UsersAuthCubit extends Cubit<UsersAuthClasses> {
  UsersAuthCubit() : super(InitialUsersAuthClasses());

  static UsersAuthCubit get(context) => BlocProvider.of(context);

/*Picked Image*/
  File? imageFile;
  String? imageUrl;

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
        imageFile = File(pickedFile.path);
    }
    emit(PickImage());
  }
  getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
      emit(PickImage());
  }
  /*User Register with Email And password*/
  void userRegister(
      {required String userFirstName,
      required String userLastName,
      required String userEmail,
      required String userPassword,
      required String userPhone}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userEmail, password: userPassword)
        .then((value) {
      emit(UserRegisterSuccess());
      print(value.user!.email);
      print(value.user!.uid);
      setUserInformation(
          id: value.user!.uid,
          userFirstName: userFirstName,
          userLastName: userLastName,
          userEmail: userEmail,
          userPhone: userPhone);
    }).catchError((error) {
      emit(UserRegisterFailed(error));
      print(error.toString());
    });
  }

  /* Set User Information*/

  void setUserInformation({
    required String id,
    required String userFirstName,
    required String userLastName,
    required String userEmail,
    required String userPhone,
  }) async {
    final ref =
        FirebaseStorage.instance.ref().child('userImage').child(id + '.jpg');
    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc(id).set({
      'id': id,
      'firstName': userFirstName,
      'lastName': userLastName,
      'email': userEmail,
      'phone': userPhone,
      'userImageUrl': imageUrl,
    });
  }

  /*User Login Method*/
  void userLogin({required String userEmail, required String userPassword}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail, password: userPassword)
        .then((value) {
      emit(UserLoginSuccess());
      print('User Login Success');
    }).catchError((error) {
      emit(UserLoginFailed(error));
      print(error.toString());
    });
  }

  /* Logout */
  void logout(){
    final FirebaseAuth auth = FirebaseAuth.instance;
   auth.signOut();
   emit(UserLogout());
  }
}
