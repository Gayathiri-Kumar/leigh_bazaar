import 'package:flutter/material.dart';
import 'package:leigh_bazaar/utils/colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double actualPrice;
  final double discountPrice;
  final double discountPercentage;
  final bool showDiscountedPrice;
  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.actualPrice,
    required this.discountPrice,
    required this.discountPercentage,
    required this.showDiscountedPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: darkblue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: darkblue,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showDiscountedPrice
                    ? Row(children: [
                        Text(
                          '\$${actualPrice.toStringAsFixed(1)}', // Original price with one decimal
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          ' \$${discountPrice.toStringAsFixed(1)}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$discountPercentage% off",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(56, 209, 4, 0.718),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Poppins'),
                        ),
                      ])
                    : Row(children: [
                        Text(
                          '\$${actualPrice.toStringAsFixed(0)}', // Only display original price
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$discountPercentage% off",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(56, 209, 4, 0.718),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Poppins'),
                        ),
                      ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
