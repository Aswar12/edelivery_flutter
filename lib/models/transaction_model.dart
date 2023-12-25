import 'dart:core';

import 'package:edelivery_flutter/models/items_model.dart';

class TransactionModel {
  int id;
  int userId;
  double totalPrice;
  double shippingPrice;
  String status;
  String address;
  String payment;
  DateTime createdAt;
  DateTime updatedAt;
  List<ItemsModel> items;

  TransactionModel({
    this.id,
    this.userId,
    this.totalPrice,
    this.shippingPrice,
    this.status,
    this.address,
    this.payment,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = double.parse(json['total_price'].toString());
    shippingPrice = double.parse(json['shipping_price'].toString());
    status = json['status'];
    address = json['address'];
    payment = json['payment'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    items = json['items']
        .map<ItemsModel>((item) => ItemsModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total_price': totalPrice,
      'shipping_price': shippingPrice,
      'status': status,
      'address': address,
      'payment': payment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
