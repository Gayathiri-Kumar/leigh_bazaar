import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leigh_bazaar/models/product.dart';

class ProductController {
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
