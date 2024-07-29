class Product {
  final String imageUrl;
  final String title;
  final String description;
  final double actualPrice;
  final double discountPercentage;

  Product({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.actualPrice,
    required this.discountPercentage,
  });
  double get discountPrice {
    double discountAmount = actualPrice * (discountPercentage / 100);
    double discountedPrice = actualPrice - discountAmount;

    return discountedPrice;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageUrl: json['thumbnail'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      actualPrice: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
    );
  }
}
