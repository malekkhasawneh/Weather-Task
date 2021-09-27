import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weather_task/Bloc/UserInformationClasses.dart';
import 'package:weather_task/Models/UsersModel.dart';

class UserInformationCubit extends Cubit<UserInformationClasses> {
  UserInformationCubit() : super(InitialUserInformationClasses());

  static UserInformationCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel userInfo = UserModel();

  File? imageFile;
  String? imageUrl;

/*get user information*/
  void getUserInformation() async {
    emit(UserInformationClassesLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      userInfo = UserModel.fromMap(value.data());
      imageUrl = userInfo.userImageUrl;
      emit(UserInformationClassesSuccess());
    });
  }

/*Picked Image*/

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    emit(UpdateUserInformationClassesPickImage());
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
    emit(UpdateUserInformationClassesPickImage());
  }

  /*Update User Info*/
  void updateUserInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    UserModel userInfo = UserModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      userImageUrl: imageUrl,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(userInfo.toMap());
    auth.currentUser!.updateEmail(email);
    emit(UpdateUserInformationClassesSuccess());
  }

  void updateUserImage() async {
    User? user = auth.currentUser;
    String userId = user!.uid;
    final ref = FirebaseStorage.instance
        .ref()
        .child('userImage')
        .child(userId + '.jpg');
    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();
  }
}
