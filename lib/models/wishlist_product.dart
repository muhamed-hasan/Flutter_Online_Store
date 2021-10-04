import 'package:flutter/material.dart';

class WishlistProduct with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  WishlistProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}
