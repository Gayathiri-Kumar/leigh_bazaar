import 'package:flutter/material.dart';
import 'package:leigh_bazaar/controllers/auth_controller.dart';
import 'package:leigh_bazaar/controllers/product_controller.dart';
import 'package:leigh_bazaar/controllers/remote_config_controller.dart';
import 'package:leigh_bazaar/models/product.dart';
import 'package:leigh_bazaar/utils/colors.dart';
import 'package:leigh_bazaar/views/product_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RemoteConfigController _remoteConfigController =
      RemoteConfigController();
  final ProductController _productController = ProductController();
  bool showDiscountedPrice = false;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _setupRemoteConfig();
  }

  Future<void> _setupRemoteConfig() async {
    await _remoteConfigController.setupRemoteConfig();
    setState(() {
      showDiscountedPrice = _remoteConfigController.shouldShowDiscountedPrice();
    });
    print(showDiscountedPrice);
  }

  Future<void> fetchData() async {
    List<Product> fetchedProducts = await _productController.fetchProducts();
    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: lightblue,
      appBar: AppBar(
        title: const Text(
          "e-Shop",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white // Make text bold
              ),
        ),
        toolbarHeight: 80,
        backgroundColor: blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async {
              await Provider.of<AuthController>(context, listen: false)
                  .signOut();
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "Welcome, ${authController.userName ?? 'user'}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchData,
              child: products.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.lightBlue)),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            0.7, // Adjust the aspect ratio as needed
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          imageUrl: product.imageUrl,
                          title: product.title,
                          description: product.description,
                          actualPrice: product.actualPrice,
                          discountPrice: showDiscountedPrice
                              ? product.discountPrice
                              : product.actualPrice,
                          discountPercentage: product.discountPercentage,
                          showDiscountedPrice: showDiscountedPrice,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
