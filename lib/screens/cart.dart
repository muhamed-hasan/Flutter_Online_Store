import 'package:flutter/material.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/screens/widgets/cart_empty.dart';
import 'package:online_store/screens/widgets/cart_item.dart';
import 'package:online_store/screens/widgets/custom_button.dart';
import 'package:online_store/services/payment.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/Cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  var response;
  Future<void> payWithCard({required int amount}) async {
    ProgressDialog dialog = ProgressDialog(context: context);
    // dialog.style(message: 'Please wait...');
    dialog.show(max: 100, msg: 'Please wait...');
    // await dialog.show();
    response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());
    dialog.close();
    print('response : ${response.success}');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _cartProducts = Provider.of<CartProvider>(context);
    return _cartProducts.cartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
              centerTitle: true,
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
                        productId: _cartProducts.cartItems.keys.toList()[index],
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
                onTap: () {
                  payWithCard(
                    amount: total.toInt(),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
