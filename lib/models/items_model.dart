import 'package:edelivery_flutter/models/product_model.dart';

class ItemsModel {
  int id;
  int userId;
  int productsId;
  int transactionsId;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;

  ItemsModel({
    this.id,
    this.productsId,
    this.userId,
    this.transactionsId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionsId = json['transactions_id'];
    productsId = json['products_id'];
    quantity = json['quantity'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'transactions_id': transactionsId,
      'products_id': productsId,
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
