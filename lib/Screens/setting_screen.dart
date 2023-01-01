// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var coverImage = HomeCubit.get(context).coverImage;
    var profileImage = HomeCubit.get(context).profileImage;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;
        bioController.text = model!.bio!;
        nameController.text = model.name!;
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 240,
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                image: DecorationImage(
                                  image:
                                      HomeCubit.get(context).userModel!.cover ==
                                              null
                                          ? AssetImage("assets/chat1.png")
                                          : FileImage(HomeCubit.get(context)
                                              .coverImage!) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getCoverImage(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        phone: phoneController.text);
                                  },
                                  icon: Icon(Icons.camera_alt),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 45,
                                child: CircleAvatar(
                                  radius: 43,
                                  backgroundImage:
                                      HomeCubit.get(context).userModel!.image ==
                                              null
                                          ? AssetImage("assets/chat1.png")
                                          : FileImage(HomeCubit.get(context)
                                              .profileImage!) as ImageProvider,
                                  child: Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: CircleAvatar(
                                      radius: 18,
                                      child: IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .getProfileImage(
                                            bio: bioController.text,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.camera_alt,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    nameController.text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 4, child: Center(child: Text("${model.bio}"))),
                      Expanded(
                        child: OutlinedButton(
                            onPressed: (() {
                              showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 300,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, right: 10, left: 10),
                                      child: Column(
                                        children: [
                                          myTextFormField(
                                            controller: nameController,
                                            label: Text("name"),
                                            prefixIcon: Icon(Icons.person),
                                            keyboardType: TextInputType.name,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          myTextFormField(
                                            controller: bioController,
                                            label: Text("Write Your bio"),
                                            prefixIcon: Icon(Icons.book),
                                            keyboardType: TextInputType.name,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          myTextFormField(
                                            controller: phoneController,
                                            label: Text("Phone"),
                                            prefixIcon: Icon(Icons.book),
                                            keyboardType: TextInputType.name,
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                HomeCubit.get(context)
                                                    .UpdateUserData(
                                                        name:
                                                            nameController.text,
                                                        bio: bioController.text,
                                                        phone: phoneController
                                                            .text);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Update",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                            child: Icon(
                              Icons.edit,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("100"),
                            Text("Posts"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("100"),
                            Text("Photos"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("100"),
                            Text("Followers"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("100"),
                            Text("Followings"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text("EDIT PROFILE"),
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
