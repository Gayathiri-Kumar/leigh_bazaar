class Product {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  double? discountedPrice;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }

  void calculateDiscountedPrice() {
    discountedPrice = price - (price * discountPercentage / 100);
  }
}