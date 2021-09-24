import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_store/screens/widgets/feed_product.dart';

class Feeds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: SizedBox(
            width: 600,
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 6,
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) => FeedProduct(),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(3, index.isEven ? 4 : 4.5),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 15.0,
            ),
          ),
        ));
  }
}
