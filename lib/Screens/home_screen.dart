// ignore_for_file: prefer_const_constructors

import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).model != null,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      if (!HomeCubit.get(context).model!.isVerification!)
                        Row(
                          children: [
                            Text("check mail"),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  Fluttertoast.showToast(
                                      msg: "Check Your mail");
                                  HomeCubit.get(context).getUserData();
                                  print(
                                      "${HomeCubit.get(context).model!.isVerification}");
                                  print("sendEmailVerification");
                                }).catchError((onError) {
                                  print(
                                      "ErrosendEmailVerification ${onError.toString()}");
                                });
                              },
                              child: Text("Sind"),
                            )
                          ],
                        ),
                      Text("DDDDDDDDDDDDDDDDDDDDOOOOOOOOOOOOONW"),
                    ],
                  ),
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }
}
