import 'dart:convert';

import 'package:edelivery_flutter/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/cart_model.dart';
import 'package:edelivery_flutter/services/transaction_service.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  List<TransactionModel> _transactionsHistory = [];
  List<TransactionModel> get transactions => _transactions;
  List<TransactionModel> get transactionsHistory => _transactionsHistory;
  set transactions(List<TransactionModel> transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  set transactionsHistory(List<TransactionModel> transactionsHistory) {
    _transactionsHistory = transactionsHistory;
    notifyListeners();
  }

  Future<bool> checkout(String token, List<CartModel> carts, double totalPrice,
      int userAddressId, String address) async {
    try {
      if (await TransactionService()
          .checkout(token, carts, totalPrice, userAddressId, address)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return false;
    }
  }

  Future<void> getOrderList() async {
    try {
      Response response = await TransactionService().getOrderList();

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data']['data'];
        _transactions = [];
        _transactionsHistory = [];
        for (var element in data) {
          TransactionModel transaction = TransactionModel.fromJson(element);
          if (transaction.status == 'SUCCESS') {
            _transactionsHistory.add(transaction);
          } else {
            _transactions.add(transaction);
          }
        }
      } else {
        // ignore: avoid_print
        print('Gagal Mendapatkan Data Order!');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<bool> addRating(int id, String note, int _rating) async {
    try {
      var rating = double.parse(_rating.toString());
      Response response =
          await TransactionService().addRating(id, note, rating);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Berhasil Menambahkan Rating');
        return true;
      } else {
        // ignore: avoid_print
        print('Gagal Menambahkan Rating');
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
