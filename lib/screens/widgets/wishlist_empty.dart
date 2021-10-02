import 'package:flutter/material.dart';
import 'package:online_store/screens/widgets/custom_button.dart';

import '../feeds.dart';

class WishListEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/wishlist.png'))),
          ),
          const SizedBox(height: 50),
          Text(
            'Your Wishlist Is Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 36,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          Text(
            'Looks Like You didn\'t\n add anything to your Wishlist',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 30),
          CustomButton(
              title: 'SHOP NOW',
              onTap: () =>
                  Navigator.of(context).pushNamed(FeedsScreen.routeName))
        ],
      ),
    );
  }
}
