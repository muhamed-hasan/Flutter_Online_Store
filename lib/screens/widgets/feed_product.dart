import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/screens/inner_screen/product_details.dart';
import 'package:provider/provider.dart';

class FeedProduct extends StatefulWidget {
  const FeedProduct({
    Key? key,
  }) : super(key: key);
  @override
  State<FeedProduct> createState() => _FeedProductState();
}

class _FeedProductState extends State<FeedProduct> {
  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<Product>(context, listen: false);

    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(ProductDetails.routeName,
          arguments: {'product': _product}),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: double.infinity,
                      constraints:
                          const BoxConstraints(minHeight: double.infinity),
                      child: Image.network(
                        _product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  _product.isPopular
                      ? Positioned(
                          left: 0,
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(left: 5, bottom: 2, right: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${_product.price}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.w900),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_product.quantity} Available",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                          onPressed: () {
                            //TODO
                          },
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.grey,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
