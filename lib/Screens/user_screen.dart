import 'package:chat_app/module/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserScreen extends StatelessWidget {
  UserScreen({this.userModel});
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("UserScreen"),));
  }
}
