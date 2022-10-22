import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:edelivery_flutter/models/product_model.dart';

class ProductService {
  String baseUrl = 'http://edelivery.my.id/api';

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('gagal get product');
    }
  }

  Future<List<ProductModel>> getProductsByName(query) async {
    var url = '$baseUrl/products?name=$query';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception('gagal get product');
    }
  }
}
