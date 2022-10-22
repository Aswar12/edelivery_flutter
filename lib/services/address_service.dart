import 'dart:async';
import 'dart:convert';

import 'package:edelivery_flutter/models/user_location_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressService {
  String baseUrl = 'http://edelivery.my.id/api';
  Future<List<UserLocationModel>> getAddress(String token) async {
    var url = '$baseUrl/address';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['data'];
      List<UserLocationModel> locations = [];

      for (var item in data) {
        locations.add(UserLocationModel.fromJson(item));
      }
      print(locations);
      return locations;
    } else {
      throw Exception('gagal get address');
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
}
