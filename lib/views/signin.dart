import 'package:flutter/material.dart';
import 'package:leigh_bazaar/controllers/auth_controller.dart';
import 'package:leigh_bazaar/controllers/product_controller.dart';
import 'package:leigh_bazaar/models/product.dart';
import 'package:leigh_bazaar/views/product_list.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  final ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password')),
            ElevatedButton(
              onPressed: () async {
                await _authController.signInWithEmail(
                    emailController.text, passwordController.text);
                List<Product> products =
                    await _productController.fetchProducts();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductListPage(products: products)),
                );
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
