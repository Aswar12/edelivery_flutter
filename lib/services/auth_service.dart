// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:edelivery_flutter/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String baseUrl = 'http://edelivery.my.id/api';

  Future<UserModel> fetch(String token) async {
    var url = '$baseUrl/user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(url, headers: headers);
  }

  Future<UserModel> register({
    String name,
    String username,
    String email,
    String password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String email,
    String password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userdata = jsonEncode(user);
      prefs.setString('user', userdata);
      prefs.setString('token', user.token);
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> autoLogin() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userData = jsonDecode(pref.get('user')) as Map<String, dynamic>;
      UserModel user = userData != null ? UserModel.fromJson(userData) : null;
      user.token = pref.get('token');
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel> logOut() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final userData = jsonDecode(pref.get('user')) as Map<String, dynamic>;
      var url = '$baseUrl/login';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': userData['token']
      };
      var body = jsonEncode({});
      var response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      return response.statusCode == 200 ? UserModel.fromJson(userData) : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
