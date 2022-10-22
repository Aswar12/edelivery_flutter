import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/product_model.dart';
import 'package:edelivery_flutter/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProductsByName(String query) async {
    try {
      List<ProductModel> products =
          await ProductService().getProductsByName(query);
      _products = products;
      notifyListeners();
      return products;
    } catch (e) {
      print(e);
    }
  }
}
