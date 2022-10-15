import 'package:edelivery_flutter/models/user_location_model.dart';

class UserModel {
  int id;
  String name;
  String email;
  String username;
  UserLocationModel userLocation;
  String profilePhotoUrl;
  String token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.userLocation,
    this.profilePhotoUrl,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userLocation = UserLocationModel.fromJson(json['user_location']);
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user_location': userLocation.toJson(),
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
