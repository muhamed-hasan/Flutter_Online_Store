import 'package:flutter/material.dart';
import 'package:online_store/constants/theme_data.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/provider/theme_provider.dart';
import 'package:online_store/screens/cart.dart';
import 'package:online_store/screens/feeds.dart';
import 'package:online_store/screens/wishlist.dart';
import 'package:provider/provider.dart';

import 'screens/bottom_bar.dart';
import 'screens/inner_screen/brands_navigation_rail.dart';
import 'screens/inner_screen/product_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeProvider = ThemeProvider();

  void getTheme() {
    themeProvider.themePrefrences
        .getThemePrefs()
        .then((value) => themeProvider.darkTheme = value);
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => themeProvider),
          ChangeNotifierProvider(create: (_) => Products()),
        ],
        child: Consumer<ThemeProvider>(builder: (context, themeData, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: BottomBarScreen(),
            routes: {
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              FeedsScreen.routeName: (ctx) => FeedsScreen(),
              WishListScreen.routeName: (ctx) => WishListScreen(),
              ProductDetails.routeName: (ctx) => const ProductDetails(),
            },
          );
        }));
  }
}
