import 'package:flutter/material.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/screens/widgets/cart_empty.dart';
import 'package:online_store/screens/widgets/cart_item.dart';
import 'package:online_store/screens/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart';
  @override
  Widget build(BuildContext context) {
    final _cartProducts = Provider.of<CartProvider>(context);
    return _cartProducts.cartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Theme.of(context).textSelectionColor,
            ),
            // bottomSheet: checkOut(context),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _cartProducts.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        cartProduct:
                            _cartProducts.cartItems.values.toList()[index],
                      );
                    },
                  ),
                ),
                checkOut(context, _cartProducts.totalAmount),
                const SizedBox(height: 20)
              ],
            ),
          );
  }

  Widget checkOut(BuildContext context, double total) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$ ${total.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              CustomButton(
                title: 'Checkout',
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
