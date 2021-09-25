import 'package:flutter/material.dart';

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
    'Addidas',
    "Apple",
    "Dell",
    "H&M",
    "Nike",
    "Samsung",
    "Huawei",
    "All",
  ];
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, int>?;
    _selectedIndex = routeArgs!['index']!;
    print(routeArgs.toString());

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
                          if (_selectedIndex == 0) {
                            setState(() {
                              brand = 'Addidas';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brand = 'Apple';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brand = 'Dell';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              brand = 'H&M';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              brand = 'Nike';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              brand = 'Samsung';
                            });
                          }
                          if (_selectedIndex == 6) {
                            setState(() {
                              brand = 'Huawei';
                            });
                          }
                          if (_selectedIndex == 7) {
                            setState(() {
                              brand = 'All';
                            });
                          }
                          print(brand);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                        letterSpacing: 1,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
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
    icon: SizedBox.shrink(),
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
  final List<Map<String, String>> _products = [
    {
      'categoryName': 'Sun Lotion',
      'categoryImage':
          'https://eg.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/25/987712/1.jpg',
    },
    {
      'categoryName': 'Smart Tv',
      'categoryImage':
          'https://eg.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/41/769422/1.jpg?1231',
    },
    {
      'categoryName': 'Washer',
      'categoryImage':
          'https://eg.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/44/737071/1.jpg?9242',
    },
    {
      'categoryName': 'Smart watch',
      'categoryImage':
          'https://eg.jumia.is/unsafe/fit-in/300x300/filters:fill(white)/product/59/354802/1.jpg?9466',
    },
  ];
  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          // removeTop: false,
          context: context,
          child: popularProducts(_products),
        ),
      ),
    );
  }

  Widget popularProducts(List<Map<String, String>> products) {
    return SizedBox(
        // width: 200,
        child: ListView.separated(
      separatorBuilder: (context, index) => Divider(),
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
                      child: Image.network(
                        _products[index]['categoryImage']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                          onPressed: () {
                            //TODO
                          },
                          icon: const Icon(
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
                          _products[index]['categoryName']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _products[index]['categoryName']!,
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
                    '14.99\$',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor),
                  ),
                  IconButton(
                      onPressed: () {
                        //TODO
                      },
                      icon: Icon(Icons.shopping_cart_outlined))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
