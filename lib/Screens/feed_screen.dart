// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_cubit.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/comment_model.dart';
import 'package:chat_app/module/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ConditionalBuilder(
          condition: HomeCubit.get(context).posts.length > 0,
          builder: (context) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Card(
                      //   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   elevation: 10,
                      //   child: Stack(
                      //     // ignore: prefer_const_literals_to_create_immutables
                      //     children: [
                      //       Image(
                      //         image: NetworkImage(
                      //             "https://img.freepik.com/free-photo/middle-eastern-entrepreneur-wear-blue-shirt-eyeglasses-against-steel-wall-show-finger-up_627829-5319.jpg?w=740&t=st=1672132911~exp=1672133511~hmac=6f4d3e05a690b9420ddf278343d555551474c913715dc66acafcbd785c2fecb6"),
                      //         fit: BoxFit.fill,
                      //         height: 200,
                      //         width: double.infinity,
                      //       ),
                      //       Positioned(
                      //         top: 10,
                      //         left: 10,
                      //         child: Text(
                      //           "Communicat With Friends",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .headlineSmall!
                      //               .copyWith(color: Colors.white, fontSize: 18),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPosts(
                              context,
                              HomeCubit.get(context).posts[index],
                              index,
                              commentController),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 5,
                              ),
                          itemCount: HomeCubit.get(context).posts.length),
                      SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ));
      },
    );
  }
}

Widget buildPosts(
  context,
  PostModel model,
  int index,
  TextEditingController commentController,
) =>
    Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(model.image!),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${model.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 20,
                                      height: 0.8,
                                    ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          Text(
                            "${model.time}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 30,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color.fromARGB(255, 207, 203, 203),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${model.text}",
                style: TextStyle(),
                // maxLines: 3,
                // overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 6),
                    //   child: Container(
                    //     height: 25,
                    //     child: MaterialButton(
                    //       padding: EdgeInsets.zero,
                    //       minWidth: 1,
                    //       height: 0,
                    //       onPressed: () {},
                    //       child: Text(
                    //         "#SoftWare",
                    //         style: Theme.of(context).textTheme.caption!.copyWith(
                    //             color: Colors.blue,
                    //             fontSize: 13,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 3,
              ),
              if (HomeCubit.get(context).postImage != " ")
                // Container(
                //   height: 200,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(4),
                //       // ignore: prefer_const_literals_to_create_immutables
                //       boxShadow: [
                //         BoxShadow(
                //           offset: Offset(2, 3),
                //         ),
                //       ],
                //       image: DecorationImage(
                //         image : NetworkImage("${model.postImage}"),
                //         fit: BoxFit.fill,
                //       )),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.favorite_border_outlined,
                                  color: Color.fromARGB(255, 83, 92, 90),
                                  size: 25,
                                ),
                                Text(
                                    "${HomeCubit.get(context).postslike[index]}"),
                              ],
                            )),
                      ),
                      Spacer(),
                      Expanded(
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: Color.fromARGB(255, 83, 92, 90),
                                  size: 25,
                                ),
                                // HomeCubit.get(context).countComment[index]
                                Text("10 Comments"
                                    // .getCommentData(HomeCubit.get(context).countComment.toString())}"

                                    // "${HomeCubit.get(context).countComment[index]}"
                                    ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              Container(
                height: 1,
                color: Color.fromARGB(255, 207, 203, 203),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "${HomeCubit.get(context).userModel!.image}",
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: myTextFormField(
                          controller: commentController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " No Comment to send";
                            }
                          },
                          suffixIcon: IconButton(
                              onPressed: () {
                                HomeCubit.get(context).addComment(
                                  comment: commentController.text,
                                  image:
                                      HomeCubit.get(context).userModel!.image,
                                  time: DateTime.now().toString(),
                                  postId: HomeCubit.get(context).postId[index],
                                  userId: HomeCubit.get(context).userModel!.id,
                                  userName:
                                      HomeCubit.get(context).userModel!.name,
                                );
                                // HomeCubit.get(context).getCommentData(
                                //     HomeCubit.get(context).postId[index]);
                              },
                              icon: Icon(Icons.send)),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       HomeCubit.get(context).addComment()
                      //     },
                      //     child: Container(
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "write a comment...",
                      //         style: Theme.of(context).textTheme.caption!.copyWith(
                      //               fontSize: 15,
                      //             ),
                      //       ),
                      //     )),
                    ),
                    InkWell(
                        onTap: () {
                          HomeCubit.get(context)
                              .likePost(HomeCubit.get(context).postId[index]);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              color: Color.fromARGB(255, 83, 92, 90),
                              size: 20,
                            ),
                            Text(
                              "Like",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 17),
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
