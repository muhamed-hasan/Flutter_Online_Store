import 'package:backdrop/backdrop.dart';
import 'package:backdrop/scaffold.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:online_store/screens/brands_screen/brands_navigation_rail.dart';
import 'package:online_store/screens/widgets/backlayer.dart';

class Home extends StatelessWidget {
  final List<String> _banner = [
    'https://image.freepik.com/free-photo/woman-holding-various-shopping-bags-copy-space_23-2148674122.jpg',
    'https://image.freepik.com/free-vector/realistic-3d-sale-special-offer-background_23-2148965867.jpg',
    'https://image.freepik.com/free-psd/online-shopping-with-mobile-shopping-elements-mockup-template_1150-38846.jpg',
    'https://image.freepik.com/free-photo/fun-during-shopping_1098-13306.jpg',
    'https://image.freepik.com/free-vector/shopping-online-website-mobile-application-landing-page-concept-marketing-digital-marketing_144352-77.jpg',
  ];
  final List<String> _brands = [
    'https://i.pinimg.com/originals/1d/79/1e/1d791eeeda45585927193e7f74c7a7db.png',
    'https://i.pinimg.com/originals/f4/ae/17/f4ae17e0fdef8361185405752c460bd5.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4kyKGkhQxAXBvvjAcvM8KymngNOUG1B7bRw&usqp=CAU',
    'https://i.pinimg.com/originals/fe/ca/49/feca4997dc48ddd6f917c176d1451615.png',
  ];
  List<Map<String, String>> _categories = [
    {
      'categoryName': 'Phones',
      'categoryImage':
          'https://kddi-h.assetsadobe3.com/is/image/content/dam/au-com/mobile/mb_img_25.jpg?scl=1',
    },
    {
      'categoryName': 'Laptop',
      'categoryImage':
          'https://ochanjang.com/wp-content/uploads/2021/01/6t8Zh249QiFmVnkQdCCtHK.jpg',
    },
    {
      'categoryName': 'Accessories',
      'categoryImage':
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MWP22?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1591634795000',
    },
    {
      'categoryName': 'Video Games',
      'categoryImage':
          'https://raqamitv.com/wp-content/uploads/2020/11/Playstation-5.jpg',
    },
  ];
  List<Map<String, String>> _products = [
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
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      frontLayerBackgroundColor: Theme.of(context).backgroundColor,
      headerHeight: MediaQuery.of(context).size.height * .25,
      appBar: BackdropAppBar(
        title: const Text("Backdrop Example"),
        leading: const BackdropToggleButton(
          icon: AnimatedIcons.home_menu,
        ),
        actions: [
          IconButton(
              iconSize: 30,
              onPressed: () {
                //TODO
              },
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg'),
              ))
        ],
      ),
      backLayer: BackLayerMenu(),
      frontLayer: Center(
        child: Container(
          alignment: Alignment.center,
          width: 800,
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainBanner(),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                category(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Popular Brands',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            //TODO
                          },
                          child: Text(
                            'View all >>',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.grey),
                          ))
                    ],
                  ),
                ),
                Center(child: popularBrands(context)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Popular Products',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            //TODO
                          },
                          child: Text(
                            'View all >>',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.grey),
                          ))
                    ],
                  ),
                ),
                popularProducts(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainBanner() {
    return SizedBox(
      height: 200,
      width: 600,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _banner[index],
            fit: BoxFit.cover,
          );
        },
        itemCount: _banner.length,
        pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }

  Widget popularBrands(BuildContext context) {
    return SizedBox(
      height: 210,
      width: 500,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              _brands[index],
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: _brands.length,
        onTap: (index) {
          Navigator.of(context).pushNamed(BrandNavigationRailScreen.routeName,
              arguments: {'index': index});
        },
        // control: SwiperControl(),
      ),
    );
  }

  Widget category() {
    return SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          itemBuilder: (context, index) => Card(
            elevation: 3,
            margin: const EdgeInsets.all(5),
            child: SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      _categories[index]['categoryImage']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _categories[index]['categoryName']!,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget popularProducts() {
    return SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(5),
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      bottom: 10,
                      right: 1,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _products[index]['categoryName']!,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    _products[index]['categoryName']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
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
