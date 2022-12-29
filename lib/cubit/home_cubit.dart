import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/feed_screen.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Screens/setting_screen.dart';
import 'package:chat_app/Screens/user_screen.dart';
import 'package:chat_app/cash_helper/shared_preference.dart';
import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // static HomeCubit get(context) => BlocProvider.of(context);

  void getRegister({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
  }) async {
    emit(RegisterLoadingDataState());
    print("RegisterLoadingDataState");
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        print(value.user!.email);
        creatUserData(
            name: name,
            email: email,
            password: password,
            phone: phone,
            id: value.user!.uid);
        print("RegisterSuccessDataState");
        emit(RegisterSuccessDataState());
      }).catchError((Error) {
        print("RegisterErrorDataState ${Error}");
        emit(RegisterErrorDataState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("Catch Error ${e}");
    }
  }

  void getLogingData(
    @required String? email,
    @required String? password,
  ) async {
    emit(LoginLoadingDataState());
    print("LoginLoadingDataState");
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        print("${value.user!.email}");
        print("${value.user!.uid}");

        print("LoginSuccessDataState");
        emit(LoginSuccessDataState(value.user!.uid));
      }).catchError((Error) {
        emit(LoginErrorDataState());
        print("getLoginErrorState ${Error}");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void creatUserData({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
    @required String? id,
  }) {
    print("CreatUserLoadingState");
    emit(CreatUserLoadingState());
    UserModel userModel = UserModel(
        email: email, name: name, password: password, phone: phone, id: id);
    FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userModel.toMap())
        .then((value) {
      print("CreatUserSuccessState");
      emit(CreatUserSuccessState());
    }).catchError((Error) {
      print("creatUserDataError..${Error}");
      emit(CreatUserErrorState());
    });
  }

  UserModel? userModel;
  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("User").doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print("isVerification ${userModel!.isVerification}");
      userModel!.isVerification = true;
      print("getUserData ${userModel!.email}");
      print("isVerification ${userModel!.isVerification}");
      emit(GetUserSuccessState());
      // print("getUserData ${model}");
    }).catchError((Error) {
      print("ErrorgetUserData ${Error.toString()}");
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screensButtomNavigate = [
    FeedScreen(),
    UserScreen(),
    ChatsScreen(),
    SettingScreen(),
  ];
  List<String> titels = [
    "Home",
    "Users",
    "Chats",
    "Setting",
  ];

  void changebottomNavigatBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigatBarState());
  }

  File? coverImage;
  ImagePicker picker = ImagePicker();

  Future getCoverImage() async {
    emit(CoverImageLoadingState());
    print("CoverImageLoadingState");
    final imagefile = await picker.pickImage(source: ImageSource.gallery);

    if (imagefile != null) {
      coverImage = File(imagefile.path);
      emit(CoverImageSuccessState());
    } else {
      print("Not Image Selected");
      emit(CoverImageErrorState());
    }
    //take Photo From Camera
//     List<Media>? res = await ImagesPicker.pick(
//       count: 3,
//       pickType: PickType.image,
//     );
// // Media
// // .path
// // .thumbPath (path for video thumb)
// // .size (kb)
  }

  File? profileImage;
  ImagePicker coverpicker = ImagePicker();

  Future getProfileImage() async {
    emit(ProfileImageLoadingState());
    print("ProfileImageLoadingState");
    final imagefile = await coverpicker.pickImage(source: ImageSource.gallery);

    if (imagefile != null) {
      profileImage = File(imagefile.path);
      print("image Path is : ${profileImage}");
      uploadProfileImage();
      emit(ProfileImageSuccessState());
    } else {
      print("Not Image Selected");
      emit(ProfileImageErrorState());
    }
  }

  String? profileImageurl;
  Future<void> uploadProfileImage() async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      print("${value}");
      value.ref.getDownloadURL().then((value) {
        print("getDownloadURLSuccess");

        print(value);
        profileImageurl = value;
        print(value);
      }).catchError((Error) {
        print("getDownloadURLError ${Error}");
      });
    }).catchError((Error) {
      print("uploadProfileImage ${Error}");
    });
  }
}
