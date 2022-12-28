// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                child: Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Image(
                      image: NetworkImage(
                          "https://img.freepik.com/free-photo/middle-eastern-entrepreneur-wear-blue-shirt-eyeglasses-against-steel-wall-show-finger-up_627829-5319.jpg?w=740&t=st=1672132911~exp=1672133511~hmac=6f4d3e05a690b9420ddf278343d555551474c913715dc66acafcbd785c2fecb6"),
                      fit: BoxFit.fill,
                      height: 200,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        "Communicat With Friends",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPosts(context),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: 10),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPosts(context) => Card(
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
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-photo/middle-eastern-entrepreneur-wear-blue-shirt-eyeglasses-against-steel-wall-show-finger-up_627829-5319.jpg?w=740&t=st=1672132911~exp=1672133511~hmac=6f4d3e05a690b9420ddf278343d555551474c913715dc66acafcbd785c2fecb6"),
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
                            "Osama Saleh",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                        "Tuesday, December 27, 2022",
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
            "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though, the unity and coherence of ideas among sentences is what constitutes a paragraph. A paragraph is defined as “a group of sentences or a single sentence that forms a unit” (Lunsford and Connors 116)",
            style: TextStyle(),
            // maxLines: 3,
            // overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Container(
                    height: 25,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1,
                      height: 0,
                      onPressed: () {},
                      child: Text(
                        "#SoftWare",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Container(
                    height: 25,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1,
                      height: 0,
                      onPressed: () {},
                      child: Text(
                        "#Flutter",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 3),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                      "https://img.freepik.com/free-photo/middle-eastern-entrepreneur-wear-blue-shirt-eyeglasses-against-steel-wall-show-finger-up_627829-5319.jpg?w=740&t=st=1672132911~exp=1672133511~hmac=6f4d3e05a690b9420ddf278343d555551474c913715dc66acafcbd785c2fecb6"),
                  fit: BoxFit.fill,
                )),
          ),
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
                          Text("125"),
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
                          Text("78 Comment"),
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
                    "https://img.freepik.com/free-photo/middle-eastern-entrepreneur-wear-blue-shirt-eyeglasses-against-steel-wall-show-finger-up_627829-5319.jpg?w=740&t=st=1672132911~exp=1672133511~hmac=6f4d3e05a690b9420ddf278343d555551474c913715dc66acafcbd785c2fecb6",
                  ),
                ),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "write a comment...",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 15,
                              ),
                        ),
                      )),
                ),
                InkWell(
                    onTap: () {},
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
