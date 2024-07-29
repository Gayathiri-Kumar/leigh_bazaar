import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:leigh_bazaar/controllers/remote_config_controller.dart';
import 'package:leigh_bazaar/views/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await RemoteConfigController().setupRemoteConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}
