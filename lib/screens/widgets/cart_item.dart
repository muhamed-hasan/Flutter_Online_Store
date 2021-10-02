import 'package:flutter/material.dart';

import 'package:online_store/models/cart_product.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final bool wishList;
  final CartProduct? cartProduct;
  const CartItem({
    Key? key,
    this.wishList = false,
    this.cartProduct,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: wishList ? 100 : 150,
            height: wishList ? 100 : 150,
            child: Image.network(
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
                      child: Text(
                        cartProduct!.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Text('Price : '),
                    Text(
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
                                  //TODO
                                },
                                icon: const Icon(
                                  Icons.remove,
                                )),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                width: 40,
                                child: Text(
                                  cartProduct!.quantity.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )),
                            IconButton(
                                onPressed: () {
                                  //   TODO
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
