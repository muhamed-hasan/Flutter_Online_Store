import 'package:flutter/material.dart';
import 'package:online_store/screens/widgets/cart_empty.dart';
import 'package:online_store/screens/widgets/cart_item.dart';
import 'package:online_store/screens/widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart';
  @override
  Widget build(BuildContext context) {
    List products = [1];
    return products.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            // bottomSheet: checkOut(context),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return CartItem();
                    },
                  ),
                ),
                checkOut(context),
                SizedBox(height: 20)
              ],
            ),
          );
  }

  Widget checkOut(BuildContext context) {
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
                    'US \$410 ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor),
                  ),
                ],
              ),
              CustomButton(title: 'Checkout'),
            ],
          ),
        )
      ],
    );
  }
}
