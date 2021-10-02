import 'package:flutter/cupertino.dart';
import 'package:online_store/models/cart_product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartProduct> _cartItems = {};
  Map<String, CartProduct> get cartItems {
    return {..._cartItems};
  }

  void addProduct(
      String productId, String title, String imageUrl, double price) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (cartItem) => CartProduct(
              id: cartItem.id,
              title: cartItem.title,
              imageUrl: cartItem.imageUrl,
              quantity: cartItem.quantity + 1,
              price: cartItem.price));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartProduct(
              id: DateTime.now().toString(),
              title: title,
              imageUrl: imageUrl,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
}
