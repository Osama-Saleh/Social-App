import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String? senderId;
  String? receiveId;
  String? dateTime;
  String? text;
  MessageModel({
    this.senderId,
    this.receiveId,
    this.dateTime,
    this.text,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiveId': receiveId,
      'dateTime': dateTime,
      'text': text,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] != null ? json['senderId'] as String : null,
      receiveId: json['receiveId'] != null ? json['receiveId'] as String : null,
      dateTime: json['dateTime'] != null ? json['dateTime'] as String : null,
      text: json['text'] != null ? json['text'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
