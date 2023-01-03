import 'package:chat_app/Screens/border_screen.dart';
import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/cash_helper/shared_preference.dart';
import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/post_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp();
  await SharedPreference.initialSharedPreference();

  bool? onBorder = SharedPreference.getDatabl(key: "onBorder");
  uid = SharedPreference.getDataSt(key: "uid");
  print("UID>>${uid}");
  print("border ${onBorder}");
  Widget widget;

  if (onBorder == true) {
    widget = LoginScreen();
    if (uid != null) {
      widget = HomeScreen();
    }
  } else {
    widget = BorderScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData()
        ..getPostData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
