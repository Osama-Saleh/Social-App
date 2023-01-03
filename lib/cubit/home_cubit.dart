// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:chat_app/Screens/user_screen.dart';
import 'package:chat_app/Screens/feed_screen.dart';
import 'package:chat_app/Screens/postscreen.dart';
import 'package:chat_app/Screens/setting_screen.dart';
import 'package:chat_app/Screens/chat_users_screen.dart';
import 'package:chat_app/components/component.dart';
import 'package:chat_app/cubit/home_states.dart';
import 'package:chat_app/module/comment_model.dart';
import 'package:chat_app/module/message_model.dart';
import 'package:chat_app/module/post_model.dart';
import 'package:chat_app/module/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // static HomeCubit get(context) => BlocProvider.of(context);

  void getRegister({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
  }) async {
    emit(RegisterLoadingDataState());
    // print("RegisterLoadingDataState");
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) {
        // print(value.user!.email);
        creatUserData(
            name: name,
            email: email,
            password: password,
            phone: phone,
            id: value.user!.uid);
        // print("RegisterSuccessDataState");
        emit(RegisterSuccessDataState());
      }).catchError((Error) {
        // print("RegisterErrorDataState ${Error}");
        emit(RegisterErrorDataState());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
      }
    } catch (e) {
      // print("Catch Error ${e}");
    }
  }

  void getLogingData(
    @required String? email,
    @required String? password,
  ) async {
    emit(LoginLoadingDataState());
    // print("LoginLoadingDataState");
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        // print("${value.user!.email}");
        // print("${value.user!.uid}");

        // print("LoginSuccessDataState");
        emit(LoginSuccessDataState(value.user!.uid));
      }).catchError((Error) {
        emit(LoginErrorDataState());
        // print("getLoginErrorState ${Error}");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
      }
    }
  }

  void creatUserData({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
    @required String? id,
  }) {
    // print("CreatUserLoadingState");
    emit(CreatUserLoadingState());
    UserModel userModel = UserModel(
        email: email, name: name, password: password, phone: phone, id: id);
    FirebaseFirestore.instance
        .collection("User")
        .doc(id)
        .set(userModel.toMap())
        .then((value) {
      // print("CreatUserSuccessState");
      emit(CreatUserSuccessState());
    }).catchError((Error) {
      // print("creatUserDataError..${Error}");
      emit(CreatUserErrorState());
    });
  }

  UserModel? userModel;
  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("User").doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      // print("isVerification ${userModel!.isVerification}");
      userModel!.isVerification = true;
      // print("getUserData ${userModel!.name}");
      // print("getUserData ${userModel!.bio}");
      // print("getUserData ${userModel!.email}");
      // print("getUserData ${userModel!.image}");
      // print("getUserData ${userModel!.cover}");
      print("isVerification ${userModel!.isVerification}");
      emit(GetUserSuccessState());
      // print("getUserData ${model}");
    }).catchError((Error) {
      // print("ErrorgetUserData ${Error.toString()}");
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screensButtomNavigate = [
    FeedScreen(),
    ChatUsersScreen(),
    PostScreen(),
    // ChatsScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  List<String> titels = [
    "Home",
    "Chats",
    "Poste",
    "Users",
    "Setting",
  ];

  void changebottomNavigatBar(int index, context) {
    if (index == 1) {
      getAllCUsers();
    }
    if (index == 2) {
      emit(CreatePostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavigatBarState());
    }
  }

  File? coverImage;
  ImagePicker picker = ImagePicker();

  Future getCoverImage({
    @required String? name,
    @required String? bio,
    @required String? phone,
  }) async {
    emit(CoverImageLoadingState());
    // print("CoverImageLoadingState");
    final imagefile = await picker.pickImage(source: ImageSource.gallery);

    if (imagefile != null) {
      coverImage = File(imagefile.path);
      uploadCoverImage(name: name, bio: bio, phone: phone);
      emit(CoverImageSuccessState());
    } else {
      // print("Not Image Selected");
      emit(CoverImageErrorState());
    }
    //take Photo From Camera
//     List<Media>? res = await ImagesPicker.pick(
//       count: 3,
//       pickType: PickType.image,
//     );
// // Media
// // .path
// // .thumbPath (path for video thumb)
// // .size (kb)
  }

  File? profileImage = null;
  ImagePicker profilepicker = ImagePicker();

  Future getProfileImage({
    @required String? name,
    @required String? bio,
    @required String? phone,
  }) async {
    emit(ProfileImageLoadingState());
    // print("ProfileImageLoadingState");
    final imagefile =
        await profilepicker.pickImage(source: ImageSource.gallery);

    if (imagefile != null) {
      profileImage = File(imagefile.path);
      // print("image Path is : ${profileImage}");
      uploadProfileImage(name: name, bio: bio, phone: phone);
      emit(ProfileImageSuccessState());
    } else {
      // print("Not Image Selected");
      emit(ProfileImageErrorState());
    }
  }

  // String? profileImageurl;
  Future<void> uploadProfileImage({
    @required String? name,
    @required String? bio,
    @required String? phone,
  }) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      // print("${value}");
      value.ref.getDownloadURL().then((value) {
        // print("getDownloadURLSuccess");

        // print(value);
        UpdateUserData(name: name, bio: bio, phone: phone, prfileImage: value);
        // profileImageurl = value;
        // print(value);
      }).catchError((Error) {
        // print("getDownloadURLError ${Error}");
      });
    }).catchError((Error) {
      // print("uploadProfileImage ${Error}");
    });
  }

  String? coverImageurl;
  Future<void> uploadCoverImage({
    @required String? name,
    @required String? bio,
    @required String? phone,
  }) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      // print("${value}");
      value.ref.getDownloadURL().then((value) {
        // print("getDownloadURLSuccess");

        // print(value);
        UpdateUserData(name: name, bio: bio, phone: phone, coverImage: value);

        // coverImageurl = value;
        // print(value);
      }).catchError((Error) {
        // print("getDownloadURLError ${Error}");
      });
    }).catchError((Error) {
      // print("uploadcoverImage ${Error}");
    });
  }

  void UpdateUserData({
    @required String? name,
    @required String? bio,
    @required String? phone,
    @required String? coverImage,
    @required String? prfileImage,
  }) {
    emit(UpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name ?? userModel!.name,
      bio: bio ?? userModel!.bio,
      email: userModel!.email,
      image: prfileImage ?? userModel!.image,
      cover: coverImage ?? userModel!.cover,
      id: userModel!.id,
      isVerification: false,
      phone: phone ?? userModel!.phone,
    );
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .update(
          model.toMap(),
        )
        .then((value) {
      getUserData();
      emit(UpdateUserDataSuccessState());
    }).catchError((Erorr) {
      // print("UpdateUserDataErrorState");
      emit(UpdateUserDataErrorState());
    });
  }

// File? pi;

//   Future getImagePost() async {
//     emit(GetPostImageLoadingState());
//     // print("CoverImageLoadingState");
//     final imagefile = await picker.pickImage(source: ImageSource.gallery);

//     if (imagefile != null) {
//       pi = File(imagefile.path);
//       emit(GetPostImageSuccessState());
//     } else {
//       // print("Not Image Selected");
//       emit(GetPostImageErrorState());
//     }
//   }
  File? postImage;
  Future getPostImage() async {
    emit(GetPostImageLoadingState());
    final imagee = await picker.pickImage(source: ImageSource.gallery);

    if (imagee != null) {
      postImage = File(imagee.path);
      emit(GetPostImageSuccessState());
    } else {
      print("Not Image Selected");
      emit(GetPostImageErrorState());
    }
  }

  // String? postImageurl;
  Future<void> uploadPostImage({
    @required String? time,
    @required String? text,
  }) async {
    emit(UploadPostLoadingState());
    print("UploadPostLoadingState");
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("images/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      // print("${value}");
      value.ref.getDownloadURL().then((value) {
        // postImageurl = value;
        print(value);
        creatPost(
          time: time,
          text: text,
          pImage: value,
        );
        emit(UploadPostSuccessState());
        print("UploadPostSuccessState");
      }).catchError((Error) {
        emit(UploadPostErrorState());
        print("UploadPostErrorState ${Error}");
      });
    }).catchError((Error) {
      emit(UploadPostErrorState());
      print("UploadPostErrorState ${Error}");
    });
  }

  // String? postId;
  void creatPost({
    @required String? time,
    @required String? text,
    String? pImage,
    String? postId,
  }) {
    emit(CreatPostLoadingState());
    print("CreatPostLoadingState");
    PostModel postModel = PostModel(
      name: userModel!.name,
      uid: userModel!.id,
      image: userModel!.image,
      imageid: postId,
      time: time,
      text: text ?? "",
      postImage: pImage ?? " ",
    );
    // print(userModel!.id);
    FirebaseFirestore.instance
        .collection("User")
        .doc(userModel!.id)
        .collection("Post")
        .add(postModel.toMap())
        .then((value) {
      print("CreatPostSuccessState");

      // print(value.id);
      // postId = value.id;
      // print(postId);
      emit(CreatPostSuccessState(postModel));
    }).catchError((Error) {
      print("CreatPostSuccessState..${Error}");
      emit(CreatPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> postslike = [];
  void getPostData() {
    emit(GetPostLoadingState());
    print("GetPostLoadingState");
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Post")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Likes").get().then((countLike) {
          // element.reference.collection("Comments").get()
          posts.add(PostModel.fromJson(element.data()));
          postId.add(element.id);
          postslike.add(countLike.docs.length);
          emit(GetPostSuccessState());
        }).catchError(onError);
      });

      // emit(GetPostSuccessState());
    }).catchError((Error) {
      print("GetPostErrorState ${Error.toString()}");
      emit(GetPostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void likePost(String postId) {
    emit(LikePostLoadingState());
    print("LikePostLoadingState");
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Post")
        .doc(postId)
        .collection("Likes")
        .doc(uid)
        .set({"like": true}).then((value) {
      print("LikePostSuccessState");
      emit(LikePostSuccessState());
    }).catchError((Error) {
      print("LikePostErrorState${Error}");
      emit(LikePostErrorState());
    });
  }

  void addComment({
    String? image,
    String? userName,
    String? userId,
    String? comment,
    String? postId,
    String? time,
  }) {
    emit(CommentPostLoadingState());
    print("CommentPostLoadingState");
    CommentModel commentModel = CommentModel(
        image: userModel!.image,
        userName: userModel!.name,
        dateComment: time,
        comment: comment,
        userId: uid);
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Post")
        .doc(postId)
        .collection("Comments")
        .add(commentModel.toMap())
        // .doc()
        // .set(commentModel.toMap())
        .then((value) {
      emit(CommentPostSuccessState(state));
      print("CommentPostSuccessState");
      // if (state is CommentPostSuccessState)
      getCommentData(postId!);
    }).catchError((Error) {
      print("CommentPostErrorState${Error}");
      emit(CommentPostErrorState());
    });
  }

  CommentModel? commentModel;
  List<int> countComment = [];
  void getCommentData(
    String postId,
  ) {
    emit(GetCommentPostLoadingState());
    print("GetCommentPostLoadingState");
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Post")
        .doc(postId)
        .collection("Comments")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Comments").get().then((count) {
          commentModel = CommentModel.fromJson(element.data());
          countComment.add(value.docs.length);
          print(countComment);
          print("getCommentData ${commentModel!.comment}");
        }).catchError((onError) {
          emit(GetCommentPostErrorState());
          print("GetCommentPostErrorState1 ${onError.toString()}");
        });
        // print("getCommentData ${element.id}");
      });

      emit(GetCommentPostSuccessState());
      print("GetCommentPostSuccessState");
    }).catchError((Error) {
      emit(GetCommentPostErrorState());
      print(Error);
      print("GetCommentPostErrorState ${Error.toString()}");
    });
  }

  List<UserModel> allUsers = [];
  void getAllCUsers() {
    if (allUsers.length == 0)
    // allUsers = [];
    emit(GetAllUsersLoadingState());
    print("GetAllUsersLoadingState");

    FirebaseFirestore.instance
        .collection("User")
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                // if (userModel!.id != uid)
                // allUsers = [];
                if (element.data()["id"] != uid)
                  allUsers.add(UserModel.fromJson(element.data()));
                print("GetAllUsersSuccessState");
                emit(GetAllUsersSuccessState());
              }),
              // emit(GetAllUsersSuccessState())
            })
        .catchError((onError) {
      emit(GetAllUsersErrorState());
      print("GetAllUsersErrorState");
    });
  }

  void sendMessage({
    @required receiveId,
    @required dateTime,
    @required text,
  }) {
    emit(SendMessageLoadingState());
    print("SendMessageLoadingstate");
    MessageModel messageModel = MessageModel(
      receiveId: receiveId,
      dateTime: dateTime,
      text: text,
      senderId: userModel!.id,
    );
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("Chats")
        .doc(receiveId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageLoadingState());
      print("SendMessageLoadingState");
    }).catchError((onError) {
      emit(SendMessageErrorState());
      print("SendMessageErrorState ${onError}");
    });
    FirebaseFirestore.instance
        .collection("User")
        .doc(receiveId)
        .collection("Chats")
        .doc(uid)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(ReceiveMessageSuccessState());
      print("ReceiveMessageSuccessState");
    }).catchError((onError) {
      emit(ReceiveMessageErrorState());
      print("ReceiveMessageErrorState ${onError}");
    });
  }
}
