import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigController {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> setupRemoteConfig() async {
    await _remoteConfig.setDefaults({'show_discounted_price': false});
    await _remoteConfig.fetchAndActivate();
  }

  bool shouldShowDiscountedPrice() {
    return _remoteConfig.getBool('show_discounted_price');
  }
}
