import 'package:flutter/material.dart';
import 'package:leigh_bazaar/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool showDiscountedPrice;

  ProductTile({required this.product, required this.showDiscountedPrice});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      subtitle: Text(showDiscountedPrice
          ? 'Discounted Price: ${product.discountedPrice!.toStringAsFixed(2)}'
          : 'Price: ${product.price.toStringAsFixed(2)}'),
    );
  }
}
