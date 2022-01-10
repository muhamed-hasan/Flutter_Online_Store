import 'package:flutter/material.dart';

import 'bottom_bar.dart';
import 'inner_screen/upload_product_form.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
