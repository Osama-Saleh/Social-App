import 'package:bloc/bloc.dart';
import 'package:chat_app/cash_helper/shared_preference.dart';
import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  UserModel? model;
  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("User").doc(uid).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      print("isVerification ${model!.isVerification}");
      model!.isVerification = true;
      print("getUserData ${model!.email}");
      print("isVerification ${model!.isVerification}");
      emit(GetUserSuccessState());
      // print("getUserData ${model}");
    }).catchError((Error) {
      print("ErrorgetUserData ${Error.toString()}");
      emit(GetUserErrorState());
    });
  }
}
