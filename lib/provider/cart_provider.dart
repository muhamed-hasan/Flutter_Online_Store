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

  void removeProduct(
      String productId, String title, String imageUrl, double price) {
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
          productId,
          (cartItem) => CartProduct(
              id: cartItem.id,
              title: cartItem.title,
              imageUrl: cartItem.imageUrl,
              quantity: cartItem.quantity - 1,
              price: cartItem.price));
    } else {
      _cartItems.removeWhere((key, value) => key == productId);
    }

    notifyListeners();
  }

  void deleteProduct(String productId) {
    _cartItems.removeWhere((key, value) => key == productId);

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
