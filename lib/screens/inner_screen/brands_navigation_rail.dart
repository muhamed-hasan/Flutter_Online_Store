import 'package:flutter/material.dart';
import 'package:online_store/models/cart_product.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  BrandNavigationRailScreen({Key? key}) : super(key: key);

  static const routeName = '/brands_navigation_rail';
  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
  int _selectedIndex = 0;
  final padding = 8.0;
  Map<String, int>? routeArgs;
  String? brand;
  final List<String> _brands = [
    "All",
    'Addidas',
    "Apple",
    "Dell",
    "H&M",
    "Nike",
    "Samsung",
    "Huawei",
  ];
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, int>?;
    _selectedIndex = routeArgs!['index']!;

    setState(() {
      brand = _brands[_selectedIndex];
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 56.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          brand = _brands[_selectedIndex];

                          print(brand);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.reply_outlined)),
                          const SizedBox(height: 10),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                        letterSpacing: 1,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        for (var item in _brands)
                          buildRotatedTextRailDestination(item, padding)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, brand!)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: const SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    final _products = Provider.of<ProductsProvider>(context, listen: false)
        .findByBrand(brand) as List<Product>;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          // removeTop: false,
          context: context,
          child: popularProducts(_products, context),
        ),
      ),
    );
  }

  Widget popularProducts(List<Product> _products, BuildContext context) {
    final _wishProvider = Provider.of<WishListProvider>(context);
    final _cartProvider = Provider.of<CartProvider>(context);
    return SizedBox(
        // width: 200,
        child: ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      scrollDirection: Axis.vertical,
      itemCount: _products.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        margin: const EdgeInsets.all(5),
        width: 200,
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 180,
                      width: 120,
                      child: Image.network(
                        _products[index].imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                          onPressed: () {
                            _wishProvider.addProduct(
                                _products[index].id,
                                _products[index].title,
                                _products[index].imageUrl,
                                _products[index].price);
                          },
                          icon: _wishProvider.wishListItems
                                  .containsKey(_products[index].id)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: 30,
                                )),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _products[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _products[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${_products[index].price}',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor),
                  ),
                  IconButton(
                      onPressed: () {
                        _cartProvider.addProduct(
                            _products[index].id,
                            _products[index].title,
                            _products[index].imageUrl,
                            _products[index].price);
                      },
                      icon: _cartProvider.cartItems
                              .containsKey(_products[index].id)
                          ? const Icon(Icons.shopping_cart)
                          : const Icon(Icons.add_shopping_cart_rounded))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
