// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({this.userModel});
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage("${userModel!.image}"),
                    // backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${userModel!.name}"),
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[500]!.withOpacity(.5),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            topEnd: Radius.circular(5),
                            bottomEnd: Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Hollo",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[500]!.withOpacity(.5),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            topEnd: Radius.circular(5),
                            bottomStart: Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "hi",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Write Your Message",
                          // border: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              HomeCubit.get(context).sendMessage(
                                receiveId: userModel!.id,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              );
                            },
                            icon: Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
