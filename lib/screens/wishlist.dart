import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_store/provider/wishlist_provider.dart';
import 'package:online_store/screens/widgets/cart_empty.dart';
import 'package:online_store/screens/widgets/cart_item.dart';
import 'package:online_store/screens/widgets/custom_button.dart';
import 'package:online_store/screens/widgets/wishlist_empty.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/Wishlist';

  @override
  Widget build(BuildContext context) {
    final _wishListProvider = Provider.of<WishListProvider>(context);

    return _wishListProvider.wishListItems.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                'Wishlist',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).textSelectionColor,
              centerTitle: true,
            ),
            body: WishListEmpty())
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Wishlist',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).textSelectionColor,
              centerTitle: true,
            ),
            // bottomSheet: checkOut(context),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _wishListProvider.wishListItems.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        wishList: true,
                        productId: _wishListProvider.wishListItems.keys
                            .toList()[index],
                        wishListProduct: _wishListProvider.wishListItems.values
                            .toList()[index],
                      );
                    },
                  ),
                ),
                //    checkOut(context),
                const SizedBox(height: 20)
              ],
            ),
          );
  }
}
