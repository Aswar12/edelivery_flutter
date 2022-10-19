import 'package:edelivery_flutter/models/user_location_model.dart';

class UserModel {
  int id;
  String name;
  String email;
  String username;
  List<UserLocationModel> userLocations;
  String profilePhotoUrl;
  String phoneNumber;
  String token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.userLocations,
    this.profilePhotoUrl,
    this.phoneNumber,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    // userLocations = json['user_locations']
    //     .map<UserLocationModel>((lokasi) => UserLocationModel.fromJson(lokasi))
    // .toList();
    phoneNumber = json['phone_number'];
    username = json['username'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  set selectedLocation(selectedLocation) {}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      // 'galleries': userLocations.map((lokasi) => lokasi.toJson()).toList(),
      'username': username,
      'phone_number': phoneNumber,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
