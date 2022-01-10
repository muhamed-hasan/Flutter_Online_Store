import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_store/constants/theme_data.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/provider/theme_provider.dart';
import 'package:online_store/provider/wishlist_provider.dart';
import 'package:online_store/screens/auth/login.dart';
import 'package:online_store/screens/auth/sign_up.dart';
import 'package:online_store/screens/cart.dart';
import 'package:online_store/screens/feeds.dart';
import 'package:online_store/screens/wishlist.dart';
import 'package:provider/provider.dart';

import 'screens/bottom_bar.dart';
import 'screens/inner_screen/brands_navigation_rail.dart';
import 'screens/inner_screen/product_details.dart';
import 'screens/inner_screen/upload_product_form.dart';
import 'screens/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
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

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => themeProvider),
                ChangeNotifierProvider(create: (_) => ProductsProvider()),
                ChangeNotifierProvider(create: (_) => CartProvider()),
                ChangeNotifierProvider(create: (_) => WishListProvider()),
              ],
              child: Consumer<ThemeProvider>(builder: (context, themeData, _) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MaterialApp(
                    home: Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: Styles.themeData(themeProvider.darkTheme, context),
                    home: const UserState(),
                    routes: {
                      BrandNavigationRailScreen.routeName: (ctx) =>
                          BrandNavigationRailScreen(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      FeedsScreen.routeName: (ctx) => FeedsScreen(),
                      WishListScreen.routeName: (ctx) => WishListScreen(),
                      ProductDetails.routeName: (ctx) => const ProductDetails(),
                      LoginScreen.routeName: (ctx) => LoginScreen(),
                      SignUpScreen.routeName: (ctx) => SignUpScreen(),
                      BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                      UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    },
                  );
                }
              }));
        });
  }
}
