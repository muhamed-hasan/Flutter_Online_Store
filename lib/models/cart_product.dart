import 'dart:convert';

import 'package:flutter/material.dart';

class CartProduct with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;
  CartProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}
