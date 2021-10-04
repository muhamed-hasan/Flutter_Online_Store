import 'package:flutter/material.dart';
import 'package:online_store/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

import 'package:online_store/models/cart_product.dart';
import 'package:online_store/models/wishList_product.dart';
import 'package:online_store/provider/cart_provider.dart';

class CartItem extends StatelessWidget {
  final bool wishList;
  final CartProduct? cartProduct;
  final WishlistProduct? wishListProduct;
  final String? productId;
  CartItem({
    Key? key,
    this.wishList = false,
    this.cartProduct,
    this.wishListProduct,
    this.productId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final wishProvider = Provider.of<WishListProvider>(context);
    Future<void> _showDialog(String title, String subTitle) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),
                ),
                Text(title),
              ],
            ),
            content: Text(subTitle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: wishList
                      ? () {
                          wishProvider.deleteProduct(productId!);
                          Navigator.of(context).pop();
                        }
                      : () {
                          cartProvider.deleteProduct(productId!);
                          Navigator.of(context).pop();
                        },
                  child: const Text('Yes')),
            ],
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: wishList ? 100 : 150,
            height: wishList ? 100 : 150,
            child: wishList
                ? Image.network(
                    wishListProduct!.imageUrl,
                    fit: BoxFit.contain,
                  )
                : Image.network(
                    cartProduct!.imageUrl,
                    fit: BoxFit.contain,
                  ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: wishList
                          ? Text(
                              wishListProduct!.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            )
                          : Text(
                              cartProduct!.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                            ),
                    ),
                    IconButton(
                        onPressed: () {
                          _showDialog('Are you sure', 'Delete Product');
                        },
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Text('Price : '),
                    wishList
                        ? Text(
                            '\$ ${wishListProduct!.price}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          )
                        : Text(
                            '\$ ${cartProduct!.price}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          )
                  ],
                ),
                wishList
                    ? Container()
                    : Text(
                        'Free Shipping ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      ),
                wishList
                    ? Container()
                    : Container(
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            // color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  cartProvider.removeProduct(
                                      productId!,
                                      cartProduct!.title,
                                      cartProduct!.imageUrl,
                                      cartProduct!.price);
                                },
                                icon: cartProduct!.quantity > 1
                                    ? const Icon(
                                        Icons.remove,
                                      )
                                    : const Icon(
                                        Icons.delete,
                                      )),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                width: 40,
                                child: Text(
                                  cartProduct!.quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).accentColor),
                                )),
                            IconButton(
                                onPressed: () {
                                  cartProvider.addProduct(
                                      productId!,
                                      cartProduct!.title,
                                      cartProduct!.imageUrl,
                                      cartProduct!.price);
                                },
                                icon: const Icon(
                                  Icons.add,
                                )),
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
