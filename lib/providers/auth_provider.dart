// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/user_model.dart';
import 'package:edelivery_flutter/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;

  UserModel get user => _user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  PickedFile _pickedFile;
  PickedFile get pickedFile => _pickedFile;

  final _picker = ImagePicker();
  Future<void> pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    notifyListeners();
  }

  Future<bool> upload() async {
    notifyListeners();
    bool success = false;
    http.StreamedResponse response = await updateProfile(_pickedFile);
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      String message = map["message"];
      success = true;
      print(message);

      return true;
    } else {
      print("error Upload image");
      notifyListeners();
      return false;
    }
  }

  Future<http.StreamedResponse> updateProfile(PickedFile pickedFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var url = 'http://edelivery.my.id/api/user-photo';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    });
    if (pickedFile != null) {
      File _file = File(pickedFile.path);
      request.files.add(
        http.MultipartFile(
          "file",
          File(pickedFile.path).readAsBytes().asStream(),
          File(pickedFile.path).lengthSync(),
          filename: _file.path.split('/').last,
        ),
      );
    }
    http.StreamedResponse response = await request.send();
    return response;
  }
  //upload image to api?

  Future<bool> logOut() async {
    try {
      UserModel user = await AuthService().logOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();

      _user = null;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> autologin() async {
    try {
      UserModel user = await AuthService().autoLogin();
      if (user != null) {
        _user = user;
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register({
    String name,
    String username,
    String email,
    String password,
    String phoneNumber,
    // String phoneNumber,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> fetch() async {
    try {
      UserModel user = await AuthService().fetch();
      _user = user;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updateDataUser({
    String name,
    String username,
    String phoneNumber,
  }) async {
    try {
      UserModel user = await AuthService().updateDataUser(
        name: name,
        username: username,
        phoneNumber: phoneNumber,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
