// ignore_for_file: prefer_const_constructors

import 'package:chat_app/Screens/chating_screen.dart';
import 'package:chat_app/Screens/user_screen.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/module/user_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// UserScreen
class ChatUsersScreen extends StatelessWidget {
  const ChatUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: HomeCubit.get(context).allUsers.length > 0,
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: ListView.separated(
          itemBuilder: (context, index) =>
              usersBuilder(context, HomeCubit.get(context).allUsers[index]),
          separatorBuilder: (context, index) => Container(
            height: .5,
            color: Colors.grey,
          ),
          itemCount: HomeCubit.get(context).allUsers.length,
        ),
      ),
      fallback: (context) => Center(child: Text("Not Have Any Users")),
    );
  }
}

Widget usersBuilder(context, UserModel model) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChattingScreen(userModel: model),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables

          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("${model.image}"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${model.name}",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    height: 0.8,
                  ),
            ),
          ],
        ),
      ),
    );
