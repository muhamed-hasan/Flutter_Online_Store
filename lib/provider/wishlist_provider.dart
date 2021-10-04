import 'package:flutter/cupertino.dart';
import 'package:online_store/models/wishList_product.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishlistProduct> _wishListItems = {};
  Map<String, WishlistProduct> get wishListItems {
    return {..._wishListItems};
  }

  void addProduct(
      String productId, String title, String imageUrl, double price) {
    if (_wishListItems.containsKey(productId)) {
      _wishListItems.removeWhere((key, value) => key == productId);
    } else {
      _wishListItems.putIfAbsent(
          productId,
          () => WishlistProduct(
              id: DateTime.now().toString(),
              title: title,
              imageUrl: imageUrl,
              price: price));
    }
    notifyListeners();
  }

  void deleteProduct(String productId) {
    _wishListItems.removeWhere((key, value) => key == productId);

    notifyListeners();
  }
}
