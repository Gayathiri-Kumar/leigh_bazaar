import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leigh_bazaar/controllers/auth_controller.dart';
import 'package:leigh_bazaar/utils/colors.dart';
import 'package:leigh_bazaar/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        theme: lightMode,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: const Text(
            "Leigh Bazaar",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: darkblue,
          nextScreen: SplashScreen(),
          animationDuration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
