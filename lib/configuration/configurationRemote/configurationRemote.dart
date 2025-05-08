import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> initializeRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ),
  );

  await remoteConfig.setDefaults(const {
    'welcome_message': 'Hola por defecto desde Remote Config',
    'show_ads': true,
  });

  await remoteConfig.fetchAndActivate();
}
