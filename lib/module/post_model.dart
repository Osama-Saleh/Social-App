import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  String? name;
  String? uid;
  String? imageid;
  String? image;
  String? time;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uid,
    this.imageid,
    this.image,
    this.time,
    this.text,
    this.postImage, 
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'imageid': imageid,
      'image': image,
      'time': time,
      'text': text,
      'postImage ': postImage,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json['name'] != null ? json['name'] as String : null,
      uid: json['uid'] != null ? json['uid'] as String : null,
      imageid: json['imageid'] != null ? json['imageid'] as String : null,
      image: json['image'] != null ? json['image'] as String : null,
      time: json['time'] != null ? json['time'] as String : null,
      text: json['text'] != null ? json['text'] as String : null,
      postImage: json['postImage'] != null ? json['postImage'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory PostModel.fromJson(String source) =>
  //     PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
