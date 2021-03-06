import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:online_store/constants/colors.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/provider/theme_provider.dart';
import 'package:online_store/provider/wishlist_provider.dart';
import 'package:online_store/screens/cart.dart';
import 'package:online_store/screens/widgets/feed_product.dart';
import 'package:online_store/screens/wishlist.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({
    Key? key,
  }) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey previewContainer = GlobalKey();
  Product? _product;
  final padding = 8.0;
  String? productId;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    productId = ModalRoute.of(context)!.settings.arguments as String;
    _product = Provider.of<ProductsProvider>(context).findById(productId!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context, listen: false);
    final _suggestedProducts =
        Provider.of<ProductsProvider>(context, listen: false).popularProducts;
    final _cartProduct = Provider.of<CartProvider>(context);
    final _wishListProvider = Provider.of<WishListProvider>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          foregroundColor: Theme.of(context).textSelectionColor,
          // backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            _product!.title,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: KColorsConsts.favBadgeColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishListScreen.routeName);
                  },
                ),
                CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Theme.of(context).accentColor,
                  child: FittedBox(
                      child: Text(
                    _wishListProvider.wishListItems.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
                CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Theme.of(context).accentColor,
                  child: FittedBox(
                      child: Text(
                    _cartProduct.cartItems.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
          ]),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                          child: Image.network(_product!.imageUrl,
                              fit: BoxFit.contain)),
                      _product!.isPopular
                          ? Positioned(
                              left: 50,
                              child: Badge(
                                toAnimate: true,
                                shape: BadgeShape.square,
                                badgeColor: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(8),
                                badgeContent: const Text('Popular',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                // const SizedBox(height: 260),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.share,
                                size: 23,
                                color: Theme.of(context).textSelectionColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                _product!.title,
                                maxLines: 2,
                                style: const TextStyle(
                                  // color: Theme.of(context).textSelectionColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'US \$ ${_product!.price}',
                              style: TextStyle(
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : KColorsConsts.subTitle,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21.0),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 3.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _product!.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 21.0,
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : KColorsConsts.subTitle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _details(
                          themeState.darkTheme, 'Brand: ', _product!.brand),
                      _details(themeState.darkTheme, 'Quantity: ',
                          _product!.quantity.toString()),
                      _details(themeState.darkTheme, 'Category: ',
                          _product!.productCategory),
                      // _details(themeState.darkTheme, 'Popularity: ',
                      //     _product!.isPopular.toString()),
                      const SizedBox(height: 15),
                      const Divider(),

                      // const SizedBox(height: 15.0),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : KColorsConsts.subTitle,
                                ),
                              ),
                            ),
                            const SizedBox(height: 70),
                            const Divider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 300,
                    child: ListView.builder(
                      itemCount: _suggestedProducts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ChangeNotifierProvider.value(
                          value: _suggestedProducts[index],
                          child: const SizedBox(
                            width: 200,
                            child: FeedProduct(),
                          ),
                        );
                        // return Container();
                      },
                    ))
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                      onPressed: () {
                        _cartProduct.addProduct(_product!.id, _product!.title,
                            _product!.imageUrl, _product!.price);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Added To Cart'),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      child: Text(
                        'Add to Cart'.toUpperCase(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          backgroundColor: Theme.of(context).backgroundColor),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textSelectionColor),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: 50,
                    child: InkWell(
                      splashColor: KColorsConsts.favColor,
                      onTap: () {
                        _wishListProvider.addProduct(
                            _product!.id,
                            _product!.title,
                            _product!.imageUrl,
                            _product!.price);
                      },
                      child: !_wishListProvider.wishListItems
                              .containsKey(_product!.id)
                          ? const Icon(
                              Icons.favorite_border,
                              color: KColorsConsts.favBadgeColor,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: KColorsConsts.favBadgeColor,
                            ),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState
                  ? Theme.of(context).disabledColor
                  : KColorsConsts.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
