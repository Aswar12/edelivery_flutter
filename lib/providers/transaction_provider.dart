import 'package:flutter/material.dart';
import 'package:edelivery_flutter/models/cart_model.dart';
import 'package:edelivery_flutter/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
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
}
