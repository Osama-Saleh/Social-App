// ignore_for_file: prefer_const_constructors

import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/cash_helper/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BorderScreen extends StatefulWidget {
  const BorderScreen({super.key});

  @override
  State<BorderScreen> createState() => _BorderScreenState();
}

class _BorderScreenState extends State<BorderScreen> {
  var pgController = PageController();
  bool isLast = false;
  List<Widget> imageBorder = [
    Image(image: AssetImage("assets/chat1.png")),
    Image(image: AssetImage("assets/chat2.png")),
    Image(image: AssetImage("assets/chat3.png")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                SharedPreference.saveData(key: "onBorder", value: true)
                    .then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                }).catchError((Error) {
                  print("Error..${Error}");
                });
              },
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 400,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: pgController,
                  onPageChanged: (value) {
                    if (value == imageBorder.length - 1) {
                      setState(() {
                        isLast = true;
                        print("latest Page");
                      });
                    } else {
                      setState(() {
                        isLast = false;
                        print("Not latest Page");
                      });
                    }
                  },
                  itemBuilder: (context, index) {
                    return imageBorder[index];
                  },
                  itemCount: imageBorder.length,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SmoothPageIndicator(
                    controller: pgController, // PageController
                    count: imageBorder.length,
                    effect: WormEffect(), // your preferred effect
                  ),
                  ElevatedButton(
                      onPressed: () {
                        pgController.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn);
                        if (isLast == true) {
                          SharedPreference.saveData(
                                  key: "onBorder", value: true)
                              .then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          }).catchError((Error) {
                            print("SharedPref saveData${Error}");
                          });
                        }
                      },
                      child: Text("Next"))
                ],
              )
            ],
          ),
        ));
  }
}
