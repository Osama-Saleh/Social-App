// ignore_for_file: prefer_const_constructors

import 'package:chat_app/Screens/postscreen.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      listener: (context, state) {
        if (state is CreatePostState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostScreen(),
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              HomeCubit.get(context)
                  .titels[HomeCubit.get(context).currentIndex],
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).userModel != null,
            builder: (context) {
              return HomeCubit.get(context)
                  .screensButtomNavigate[HomeCubit.get(context).currentIndex];
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: HomeCubit.get(context).currentIndex,
              fixedColor: Color.fromARGB(255, 2, 65, 97),
              unselectedItemColor: Colors.grey,

              // selectedItemColor: Colors.red,
              onTap: (Index) =>
                  HomeCubit.get(context).changebottomNavigatBar(Index, context),
              type: BottomNavigationBarType.shifting,
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.post_add),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'User',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'settings',
                ),
              ]),
        );
      },
    );
  }
}




// Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       if (!HomeCubit.get(context).model!.isVerification!)
//                         Row(
//                           children: [
//                             Text("check mail"),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 FirebaseAuth.instance.currentUser!
//                                     .sendEmailVerification()
//                                     .then((value) {
//                                   Fluttertoast.showToast(
//                                       msg: "Check Your mail");
//                                   HomeCubit.get(context).getUserData();
//                                   print(
//                                       "${HomeCubit.get(context).model!.isVerification}");
//                                   print("sendEmailVerification");
//                                 }).catchError((onError) {
//                                   print(
//                                       "ErrosendEmailVerification ${onError.toString()}");
//                                 });
//                               },
//                               child: Text("Sind"),
//                             )
//                           ],
//                         ),
//                       Text("Done Verification"),
//                     ],
//                   ),
//                 );
