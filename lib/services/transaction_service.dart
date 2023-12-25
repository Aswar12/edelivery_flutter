// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:edelivery_flutter/models/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class TransactionService {
  String baseUrl = 'http://edelivery.my.id/api';

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      int userAddressId, String address) async {
    var url = '$baseUrl/checkout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'user_location_id': userAddressId,
        'address': address,
        'items': carts
            .map(
              (cart) => {
                'id': cart.product.id,
                'quantity': cart.quantity,
              },
            )
            .toList(),
        'status': "PENDING",
        'total_price': totalPrice,
        'shipping_price': 5000,
      },
    );

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Melakukan Checkout!');
    }
  }

  Future<http.Response> getOrderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = '$baseUrl/transactions';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Gagal Mendapatkan Data Transaksi!');
    }
  }

  addRating(int id, String note, double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = '$baseUrl/addrating';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode(
      {
        'id': id,
        'note': note,
        'rating': rating,
      },
    );

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Gagal Melakukan Rating!');
    }
  }
}
