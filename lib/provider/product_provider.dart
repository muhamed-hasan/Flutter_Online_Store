import 'package:flutter/cupertino.dart';
import 'package:online_store/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
        id: 'Samsung1',
        title: 'Samsung Galaxy S9',
        description:
            'Samsung Galaxy S9 G960U 64GB Unlocked GSM 4G LTE Phone w/ 12MP Camera - Midnight Black',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/81%2Bh9mpyQmL._AC_SL1500_.jpg',
        brand: 'Samsung',
        productCategory: 'Phones',
        quantity: 65,
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A10s',
        title: 'Samsung Galaxy A10s',
        description:
            'Samsung Galaxy A10s A107M - 32GB, 6.2" HD+ Infinity-V Display, 13MP+2MP Dual Rear +8MP Front Cameras, GSM Unlocked Smartphone - Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg',
        brand: 'Samsung ',
        productCategory: 'Phones',
        quantity: 1002,
        isPopular: false),
    Product(
        id: 'Samsung Galaxy A51',
        title: 'Samsung Galaxy A51',
        description:
            'Samsung Galaxy A51 (128GB, 4GB) 6.5", 48MP Quad Camera, Dual SIM GSM Unlocked A515F/DS- Global 4G LTE International Model - Prism Crush Blue.',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/61HFJwSDQ4L._AC_SL1000_.jpg',
        brand: 'Samsung',
        productCategory: 'Phones',
        quantity: 6423,
        isPopular: true),
    Product(
        id: 'Huawei P40 Pro',
        title: 'Huawei P40 Pro',
        description:
            'Huawei P40 Pro (5G) ELS-NX9 Dual/Hybrid-SIM 256GB (GSM Only | No CDMA) Factory Unlocked Smartphone (Silver Frost) - International Version',
        price: 900.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/6186cnZIdoL._AC_SL1000_.jpg',
        brand: 'Huawei',
        productCategory: 'Phones',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro',
        title: 'iPhone 12 Pro',
        description:
            'New Apple iPhone 12 Pro (512GB, Gold) [Locked] + Carrier Subscription',
        price: 1100,
        imageUrl: 'https://m.media-amazon.com/images/I/71cSV-RTBSL.jpg',
        brand: 'Apple',
        productCategory: 'Phones',
        quantity: 3,
        isPopular: true),
    Product(
        id: 'iPhone 12 Pro Max ',
        title: 'iPhone 12 Pro Max ',
        description:
            'New Apple iPhone 12 Pro Max (128GB, Graphite) [Locked] + Carrier Subscription',
        price: 50.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71XXJC7V8tL._FMwebp__.jpg',
        brand: 'Apple',
        productCategory: 'Phones',
        quantity: 2654,
        isPopular: false),
    Product(
        id: 'Hanes Mens ',
        title: 'Long Sleeve Beefy Henley Shirt',
        description: 'Hanes Men\'s Long Sleeve Beefy Henley Shirt ',
        price: 22.30,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/91YHIgoKb4L._AC_UX425_.jpg',
        brand: 'No brand',
        productCategory: 'Clothes',
        quantity: 58466,
        isPopular: true),
    Product(
        id: 'Weave Jogger',
        title: 'Weave Jogger',
        description: 'Champion Mens Reverse Weave Jogger',
        price: 58.99,
        imageUrl:
            'https://m.media-amazon.com/images/I/71g7tHQt-sL._AC_UL320_.jpg',
        brand: 'H&M',
        productCategory: 'Clothes',
        quantity: 84894,
        isPopular: false),
    Product(
        id: 'Adeliber Dresses for Womens',
        title: 'Adeliber Dresses for Womens',
        description:
            'Adeliber Dresses for Womens, Sexy Solid Sequined Stitching Shining Club Sheath Long Sleeved Mini Dress',
        price: 50.99,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/7177o9jITiL._AC_UX466_.jpg',
        brand: 'H&M',
        productCategory: 'Clothes',
        quantity: 49847,
        isPopular: true),
    Product(
        id: 'Tanjun Sneakers',
        title: 'Tanjun Sneakers',
        description:
            'NIKE Men\'s Tanjun Sneakers, Breathable Textile Uppers and Comfortable Lightweight Cushioning ',
        price: 191.89,
        imageUrl:
            'https://images-na.ssl-images-amazon.com/images/I/71KVPm5KJdL._AC_UX500_.jpg',
        brand: 'Nike',
        productCategory: 'Shoes',
        quantity: 65489,
        isPopular: false)
  ];

  List<Product> get products {
    return [..._products];
  }

  List<Product> get popularProducts {
    return _products.where((element) => element.isPopular).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product>? findByCategory(String categoryName) {
    List<Product> _categoryList = _products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product>? findByBrand(String brandName) {
    if (brandName == 'All') {
      return [..._products];
    }
    List<Product> _categoryList = _products
        .where((element) =>
            element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List<Product> _searchList = _products
        .where((element) =>
            element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
}
