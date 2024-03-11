import 'dart:convert';

import '../../controller/utils/sql_helper/sql_helper.dart';

class UserModel {
  int id;
  String name;
  int? otp;
  String? towStep;
  String email;
  String? emailVerifiedAt;
  String createdAt;
  String? updatedAt;
  String token;
  List<dynamic>? careerType;
  String? workNature;
  List<dynamic>? workLocations;
  String? profileImage;
  String? mobile;
  String? bio;
  String? address;
  bool isLogin;
  UserModel({
    required this.id,
    required this.name,
    required this.otp,
    this.towStep,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    this.updatedAt,
    required this.token,
    this.careerType,
    this.workNature,
    this.workLocations,
    this.isLogin = false,
    this.profileImage,
    this.mobile,
    this.bio,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      UserTableColumnTitles.id: id,
      UserTableColumnTitles.name: name,
      UserTableColumnTitles.otp: otp,
      UserTableColumnTitles.towStep: towStep,
      UserTableColumnTitles.email: email,
      UserTableColumnTitles.emailVerifiedAt: emailVerifiedAt,
      UserTableColumnTitles.createdAt: createdAt,
      UserTableColumnTitles.updatedAt: updatedAt,
      UserTableColumnTitles.token: token,
      UserTableColumnTitles.careerType: careerType,
      UserTableColumnTitles.workNature: workNature,
      UserTableColumnTitles.workLocations: workLocations,
      UserTableColumnTitles.login: isLogin,
      UserTableColumnTitles.profileImage: profileImage,
      UserTableColumnTitles.mobile: mobile,
      UserTableColumnTitles.bio: bio,
      UserTableColumnTitles.address: address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[UserTableColumnTitles.id] as int,
      name: map[UserTableColumnTitles.name] as String,
      otp: map[UserTableColumnTitles.otp] as int?,
      towStep: map[UserTableColumnTitles.towStep] != null
          ? map[UserTableColumnTitles.towStep] as String
          : null,
      email: map[UserTableColumnTitles.email] as String,
      emailVerifiedAt: map[UserTableColumnTitles.emailVerifiedAt] != null
          ? map[UserTableColumnTitles.emailVerifiedAt] as String
          : null,
      createdAt: map[UserTableColumnTitles.createdAt] as String,
      updatedAt: map[UserTableColumnTitles.updatedAt] != null
          ? map[UserTableColumnTitles.updatedAt] as String
          : null,
      token: map[UserTableColumnTitles.token] as String,
      careerType: map[UserTableColumnTitles.careerType] != null
          ? map[UserTableColumnTitles.careerType] as List<dynamic>
          : null,
      workNature: map[UserTableColumnTitles.workNature] != null
          ? map[UserTableColumnTitles.workNature] as String
          : null,
      workLocations: map[UserTableColumnTitles.workLocations] != null
          ? map[UserTableColumnTitles.workLocations] as List<dynamic>
          : null,
      isLogin: map[UserTableColumnTitles.login] as bool,
      profileImage: map[UserTableColumnTitles.profileImage] != null
          ? map[UserTableColumnTitles.profileImage] as String
          : null,
      mobile: map[UserTableColumnTitles.mobile] != null
          ? map[UserTableColumnTitles.mobile] as String
          : null,
      bio: map[UserTableColumnTitles.bio] != null
          ? map[UserTableColumnTitles.bio] as String
          : null,
      address: map[UserTableColumnTitles.address] != null
          ? map[UserTableColumnTitles.address] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, otp: $otp, towStep: $towStep, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, token: $token, careerType: $careerType, workNature: $workNature, workLocations: $workLocations, profileImage: $profileImage, mobile: $mobile, bio: $bio, address: $address, isLogin: $isLogin)';
  }
}
