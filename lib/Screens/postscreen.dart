// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/post_model.dart';
import 'package:chat_app/module/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();
    // var model = HomeCubit.get(context).userModel;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PostModel pmodel;
        return Scaffold(
            appBar: AppBar(
              title: Text("Create Post"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      // if (state is CreatPostSuccessState) {
                      //   if (state.postModel.text == null) {
                      //     HomeCubit.get(context).uploadPostImage(
                      //         time: DateTime.now().toString(),
                      //         text: postController.text);
                      //   } else if (HomeCubit.get(context).postss == null) {
                      //     HomeCubit.get(context).creatPost(
                      //         time: DateTime.now().toString(),
                      //         text: postController.text);
                      //   } else if (state.postModel.text == null &&
                      //       HomeCubit.get(context).postImage == null) {
                      //     print("NO posted item");
                      //   }
                      // }
                      // print("NO click");
                      if (HomeCubit.get(context).postImage == " ") {
                        HomeCubit.get(context).creatPost(
                            time: DateTime.now().toString(),
                            text: postController.text);
                      } else {
                        HomeCubit.get(context).uploadPostImage(
                            time: DateTime.now().toString(),
                            text: postController.text);
                      }
                    },
                    child: Text(
                      "POST",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            ),
            body: BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "${HomeCubit.get(context).userModel!.image}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${HomeCubit.get(context).userModel!.name}"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Public",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: postController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "No Post yet";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText:
                                  "What's your mind , ${HomeCubit.get(context).userModel!.name}",
                              border: InputBorder.none),
                        ),
                      ),
                      if (HomeCubit.get(context).postImage != null)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                      image: FileImage(
                                              HomeCubit.get(context).postImage!)
                                          as ImageProvider,
                                      fit: BoxFit.fill)),
                            ),
                            IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).removePostImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(Icons.close),
                                ))
                          ],
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {
                                  HomeCubit.get(context).getPostImage();
                                },
                                icon: Icon(Icons.image_outlined),
                                label: Text("Add Photo")),
                          ),
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {
                                  // PostModel p = PostModel();
                                  print(
                                      "Demo ${HomeCubit.get(context).postImage}");
                                },
                                icon: Icon(Icons.tag),
                                label: Text("Tages")),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
