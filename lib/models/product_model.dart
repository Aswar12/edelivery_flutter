import 'package:edelivery_flutter/models/category_model.dart';
import 'package:edelivery_flutter/models/gallery_model.dart';
import 'package:edelivery_flutter/models/kedai_model.dart';

class ProductModel {
  int id;
  String name;
  double price;
  String description;
  String tags;
  KedaiModel kedai;
  CategoryModel category;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryModel> galleries;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.tags,
    this.kedai,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    description = json['description'];
    tags = json['tags'];
    kedai = json['kedai'] == {}
        ? UninitializedKedaiModel()
        : KedaiModel.fromJson(json['kedai']);
    category = CategoryModel.fromJson(json['category']);
    galleries = json['galleries']
        .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'kedai': kedai.toJson(),
      'category': category.toJson(),
      'galleries': galleries.map((gallery) => gallery.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class UninitializedProductModel extends ProductModel {}
