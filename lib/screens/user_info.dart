import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:online_store/constants/colors.dart';
import 'package:online_store/provider/theme_provider.dart';
import 'package:online_store/screens/cart.dart';
import 'package:online_store/screens/wishlist.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _auth = FirebaseAuth.instance;
  ScrollController? _scrollController;
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeValue = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            KColorsConsts.starterColor,
                            KColorsConsts.endColor,
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      centerTitle: true,
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: top <= 110.0 ? 1.0 : .5,
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Container(
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Guest',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      background: const Image(
                        image: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userTitle('User Bag'),
                    ),
                    const Divider(),
                    userListTile(
                        context: context,
                        title: 'Wishlist',
                        subTitle: '',
                        index: 5,
                        color: Colors.red,
                        onTap: () => Navigator.of(context)
                            .pushNamed(WishListScreen.routeName)),
                    userListTile(
                        context: context,
                        title: 'Cart',
                        subTitle: '',
                        index: 6,
                        color: Colors.yellow,
                        onTap: () => Navigator.of(context)
                            .pushNamed(CartScreen.routeName)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userTitle('User Information'),
                    ),
                    const Divider(),
                    userListTile(
                        context: context,
                        title: 'Email',
                        subTitle: 'Email@mail.com',
                        index: 0),
                    userListTile(
                        context: context,
                        title: 'Phone number',
                        subTitle: '1356',
                        index: 1),
                    userListTile(
                        context: context,
                        title: 'Shipping address',
                        subTitle: 'address street',
                        index: 2),
                    userListTile(
                        context: context,
                        title: 'Joined date',
                        subTitle: '11/22/20',
                        index: 3),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: userTitle('User Settings'),
                    ),
                    const Divider(),
                    ListTileSwitch(
                      value: themeValue.darkTheme,
                      leading: Icon(Icons.dark_mode),
                      onChanged: (value) {
                        setState(() {
                          themeValue.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: const Text('Dark theme'),
                    ),
                    userListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Image.network(
                                          'https://image.flaticon.com/icons/png/128/564/564619.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Log Out'),
                                      ),
                                    ],
                                  ),
                                  content: Text('Are you sure'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          _auth.signOut();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('NO')),
                                  ],
                                );
                              });
                        },
                        context: context,
                        title: 'Logout',
                        subTitle: '',
                        index: 4),
                  ],
                ),
              )
            ],
          ),
          _changePicture()
        ],
      ),
    );
  }

  Widget _changePicture() {
    //starting fab position
    const double defaultTopMargin = 200.0 - 50;
    //pixels from top where scaling should start
    const double scaleStart = 120;
    //pixels from top where scaling should end
    const double scaleEnd = scaleStart / 1.3;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController!.hasClients) {
      //! it hasClient only when scrolling
      double offset = _scrollController!.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {},
          child: const Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  Text userTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded,
    Icons.favorite_border,
    Icons.shopping_cart_outlined
  ];

  Widget userListTile(
      {BuildContext? context,
      String? title,
      String? subTitle,
      int? index,
      Function? onTap,
      Color color = Colors.grey}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context!).splashColor,
        onTap: () {
          onTap != null ? onTap() : () {};
        },
        child: ListTile(
          title: Text(title!),
          subtitle: Text(subTitle!),
          leading: Icon(
            _userTileIcons[index!],
            color: color,
          ),
        ),
      ),
    );
  }
}
