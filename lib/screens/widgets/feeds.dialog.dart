import 'package:flutter/material.dart';
import 'package:online_store/constants/colors.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/provider/theme_provider.dart';
import 'package:online_store/provider/wishlist_provider.dart';
import 'package:online_store/screens/inner_screen/product_details.dart';
import 'package:provider/provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;
  const FeedDialog({required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);

    final cartProvider = Provider.of<CartProvider>(context);

    final favsProvider = Provider.of<WishListProvider>(context);

    final prodAttr = productsData.findById(productId);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   constraints: BoxConstraints(
          //       minHeight: 120,
          //       maxHeight: MediaQuery.of(context).size.height * 0.50),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       color: Theme.of(context).scaffoldBackgroundColor,
          //       borderRadius: const BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         topRight: Radius.circular(20),
          //       )),
          //   // child: Image.network(
          //   //   prodAttr.imageUrl,
          //   // ),
          // ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Image.network(
                    prodAttr.imageUrl,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: dialogContent(
                            context,
                            0,
                            () => {
                                  favsProvider.addProduct(
                                      productId,
                                      prodAttr.title,
                                      prodAttr.imageUrl,
                                      prodAttr.price),
                                }),
                      ),
                      Flexible(
                        child: dialogContent(
                            context,
                            1,
                            () => {
                                  Navigator.pushNamed(
                                          context, ProductDetails.routeName,
                                          arguments: prodAttr.id)
                                      .then((value) => Navigator.canPop(context)
                                          ? Navigator.pop(context)
                                          : null),
                                }),
                      ),
                      Flexible(
                        child: dialogContent(
                          context,
                          2,
                          cartProvider.cartItems.containsKey(productId)
                              ? () {}
                              : () {
                                  cartProvider.addProduct(
                                      productId,
                                      prodAttr.title,
                                      prodAttr.imageUrl,
                                      prodAttr.price);
                                },
                        ),
                      ),
                    ]),
              ],
            ),
          ),

          /************close****************/
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.3),
                shape: BoxShape.circle),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey,
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function fct) {
    final cart = Provider.of<CartProvider>(context);
    final favs = Provider.of<WishListProvider>(context);
    List<IconData> _dialogIcons = [
      favs.wishListItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Icons.view_carousel_sharp,
      Icons.shopping_cart_outlined,
    ];

    List<String> _texts = [
      favs.wishListItems.containsKey(productId)
          ? 'In wishlist'
          : 'Add to wishlist',
      'View product',
      cart.cartItems.containsKey(productId) ? 'In Cart ' : 'Add to cart',
    ];
    List<Color> _colors = [
      favs.wishListItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
    ];
    final themeChange = Provider.of<ThemeProvider>(context, listen: false);
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            fct();
          },
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          _dialogIcons[index],
                          color: _colors[index],
                          size: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      _texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        //  fontSize: 15,
                        color: themeChange.darkTheme
                            ? Theme.of(context).disabledColor
                            : KColorsConsts.subTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
