import 'package:flutter/material.dart';
import 'package:leigh_bazaar/controllers/remote_config_controller.dart';
import 'package:leigh_bazaar/models/product.dart';
import 'package:leigh_bazaar/views/product_tile.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final RemoteConfigController _remoteConfigController =
      RemoteConfigController();

  ProductListPage({required this.products});

  @override
  Widget build(BuildContext context) {
    bool showDiscountedPrice =
        _remoteConfigController.shouldShowDiscountedPrice();

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          if (showDiscountedPrice) {
            product.calculateDiscountedPrice();
          }
          return ProductTile(
              product: product, showDiscountedPrice: showDiscountedPrice);
        },
      ),
    );
  }
}
