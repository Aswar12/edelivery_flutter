// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'package:edelivery_flutter/models/user_location_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressService {
  String baseUrl = 'http://edelivery.my.id/api';
  Future<List<UserLocationModel>> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = '$baseUrl/address';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<UserLocationModel> locations = [];

      for (var item in data) {
        locations.add(UserLocationModel.fromJson(item));
      }

      return locations;
    } else {
      throw Exception('gagal get Locations');
    }
  }

  Future<http.Response> getAddressFromGeocode(LatLng latLng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    var url = '$baseUrl/geocode-api';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    });

    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: body);

    return response;
  }

  Future<UserLocationModel> addAddress({
    String customerName,
    String phoneNumber,
    String address,
    String latitude,
    String longitude,
    int addressType,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    var url = '$baseUrl/address';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'customer_name': customerName,
      'phone_number': phoneNumber,
      'address': address,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'address_type': addressType,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserLocationModel userLocationModel = UserLocationModel.fromJson(data);
      await saveUserAddressToLocal(userLocationModel);
      return userLocationModel;
    } else {
      throw Exception('gagal add address');
    }
  }

  Future<bool> saveUserAddressToLocal(UserLocationModel address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userdata = jsonEncode(address);

    return prefs.setString('userAddress', userdata);
  }

  Future<UserLocationModel> getUserAddressFormLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userAddressLocal = prefs.getString('userAddress') ?? '';
    print(userAddressLocal);
    UserLocationModel dataAddress = jsonDecode(userAddressLocal);
    return userAddressLocal.isNotEmpty ? dataAddress : null;
  }

  Future<http.Response> getAllAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('token');
    var url = '$baseUrl/address';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    http.Response response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }
}
