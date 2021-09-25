import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final bool wishList;

  const CartItem({Key? key, this.wishList = false}) : super(key: key);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: widget.wishList ? 100 : 150,
            height: widget.wishList ? 100 : 150,
            child: Image.network(
              'https://image.freepik.com/free-photo/pair-trainers_144627-3799.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        'Nike Shoe 3X',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          //TODO
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
                Row(
                  children: [
                    const Text('Price : '),
                    Text(
                      '410\$ ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor),
                    )
                  ],
                ),
                widget.wishList
                    ? Container()
                    : Text(
                        'Free Shipping ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      ),
                widget.wishList
                    ? Container()
                    : Container(
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                            // color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  //TODO
                                },
                                icon: const Icon(
                                  Icons.remove,
                                )),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                width: 40,
                                child: Text(
                                  '2',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )),
                            IconButton(
                                onPressed: () {
                                  //   TODO
                                },
                                icon: const Icon(
                                  Icons.add,
                                )),
                          ],
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
