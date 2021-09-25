import 'package:flutter/material.dart';
import 'package:online_store/screens/widgets/cart_empty.dart';
import 'package:online_store/screens/widgets/cart_item.dart';
import 'package:online_store/screens/widgets/custom_button.dart';
import 'package:online_store/screens/widgets/wishlist_empty.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/Wishlist';
  @override
  Widget build(BuildContext context) {
    List wishList = [1];
    return wishList.isEmpty
        ? Scaffold(body: WishListEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlist'),
              backgroundColor: Theme.of(context).accentColor,
            ),
            // bottomSheet: checkOut(context),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return CartItem(
                        wishList: true,
                      );
                    },
                  ),
                ),
                //    checkOut(context),
                SizedBox(height: 20)
              ],
            ),
          );
  }
}
