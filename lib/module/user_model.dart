import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? id;
  bool? isVerification;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.id,
    this.isVerification,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'id': id,
      'isVerification ': isVerification,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] != null ? json['name'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      password: json['password'] != null ? json['password'] as String : null,
      phone: json['phone'] != null ? json['phone'] as String : null,
      id: json['id'] != null ? json['id'] as String : null,
      isVerification: json['isVerification'] != null
          ? json['isVerification'] as bool
          : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
