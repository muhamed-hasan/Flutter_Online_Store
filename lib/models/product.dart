import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String productCategory;
  final String brand;
  final int quantity;
  final double price;
  final bool isFavourite;
  final bool isPopular;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.productCategory,
    this.brand = 'All',
    this.quantity = 1,
    required this.price,
    this.isFavourite = false,
    this.isPopular = false,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? productCategory,
    String? brand,
    int? quantity,
    double? price,
    bool? isFavourite,
    bool? isPopular,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      productCategory: productCategory ?? this.productCategory,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isFavourite: isFavourite ?? this.isFavourite,
      isPopular: isPopular ?? this.isPopular,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'productCategory': productCategory,
      'brand': brand,
      'quantity': quantity,
      'price': price,
      'isFavourite': isFavourite,
      'isPopular': isPopular,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      productCategory: map['productCategory'],
      brand: map['brand'],
      quantity: map['quantity'],
      price: map['price'],
      isFavourite: map['isFavourite'],
      isPopular: map['isPopular'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, imageUrl: $imageUrl, productCategory: $productCategory, brand: $brand, quantity: $quantity, price: $price, isFavourite: $isFavourite, isPopular: $isPopular)';
  }
}
