import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Function onTap;

  const CustomButton({Key? key, this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      minWidth: 170,
      onPressed: () {
        onTap();
      },
      child: Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          // fontWeight: FontWeight.w600
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(color: Theme.of(context).accentColor)),
      color: Theme.of(context).accentColor,
    );
  }
}
