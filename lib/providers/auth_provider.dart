// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/user_model.dart';
import 'package:edelivery_flutter/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;

  UserModel get user => _user;
  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

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

  Future<bool> autologin() async {
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
}
