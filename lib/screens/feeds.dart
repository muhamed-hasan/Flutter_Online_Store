import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/screens/widgets/feed_product.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';
  @override
  Widget build(BuildContext context) {
    List<Product>? _products;
    final argument = ModalRoute.of(context)?.settings.arguments;
    if (argument == null) {
      _products = Provider.of<Products>(context, listen: false).products;
    } else if (argument == 'popular') {
      _products = Provider.of<Products>(context, listen: false).popularProducts;
    } else {
      _products = Provider.of<Products>(context, listen: false)
          .findByCategory(argument.toString());
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          foregroundColor: Theme.of(context).textSelectionColor,
          title: const Text('Feeds'),
        ),
        body: Center(
            child: SizedBox(
                width: 600,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 6,
                  itemCount: _products!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ChangeNotifierProvider.value(
                    //! we cant add change notifier in main as feedProduct()
                    //! will take specific argument with data
                    //! this way we can send product with index in provider

                    value: _products![index],
                    child: const FeedProduct(),
                  ),
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(3, index.isEven ? 4 : 4.5),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 15.0,
                ))));
  }
}
