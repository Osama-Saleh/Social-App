// ignore_for_file: public_member_api_docs, sort_constructors_first


class CommentModel {
  String? userName;
  String? userId;
  String? image;
  String? comment;
  String? dateComment;
  CommentModel({
    this.userName,
    this.userId,
    this.image,
    this.comment,
    this.dateComment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userId': userId,
      'image': image,
      'comment': comment,
      'dateComment': dateComment,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userName: json['userName'] != null ? json['userName'] as String : null,
      userId: json['userId'] != null ? json['userId'] as String : null,
      image: json['image'] != null ? json['image'] as String : null,
      comment: json['comment'] != null ? json['comment'] as String : null,
      dateComment:
          json['dateComment'] != null ? json['dateComment'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
