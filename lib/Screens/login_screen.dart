// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Screens/register_screen.dart';
import 'package:chat_app/cash_helper/shared_preference.dart';
import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isSecret = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is LoginErrorDataState) {
            Fluttertoast.showToast(
                msg: "email or password incorrect",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is LoginSuccessDataState) {
            SharedPreference.saveData(key: "uid", value: state.uid)
                .then((value) => {
                      print("the UID is ${state.uid}"),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          )),
                      // uid = state.uid,
                      
                    })
                .catchError((Error) {
              print("Error Sharedpref save data ${Error}");
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 40),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        myTextFormField(
                            controller: emailController,
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {}
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your name";
                              }
                              return null;
                            },
                            label: Text("Email Address"),
                            prefixIcon: Icon(Icons.person)),
                        SizedBox(
                          height: 20,
                        ),
                        myTextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Password";
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {}
                            },
                            obscureText: isSecret,
                            label: Text("Password"),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSecret = !isSecret;
                                  });
                                  print("isSecret ${isSecret}");
                                },
                                icon: isSecret
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            prefixIcon: Icon(Icons.lock)),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  HomeCubit.get(context).getLogingData(
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ));
                                },
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
