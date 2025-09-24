import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../config/flavors/flavors.dart';
import '../../firebase_options.dart';
import '../di/service_locator.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (message.data.isNotEmpty) {
    print("Handling a background Message: ${message.messageId}");
    print("Handling a background Data: ${message.data}");
  }
}

Future<void> initApp(AppEnv env) async {
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await initDependencies(env);
  await sl.allReady();
  // await sl<CloudMessagingApi>().initialize();
  // await sl<LocalNotificationsApi>().initialize();
}
