
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_wallet/Pages/Drawer/getKycDetail.dart';
import 'package:sms_wallet/Pages/Home/GetRewards.dart';
import 'package:sms_wallet/Pages/faq.dart';
import 'package:sms_wallet/Pages/google_sign_in.dart';
import 'package:sms_wallet/Pages/splashScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sms_wallet/Pages/update.dart';
import 'package:sms_wallet/ad_state.dart';
import 'package:sms_wallet/google_ads.dart';
import 'package:sms_wallet/interstitialAd.dart';

import 'Controllers/Timer.dart';
import 'Pages/Home/Tawk_Support.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);


/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var id = prefs.getString('id');
  bool intro=prefs.getBool('intro');
  var api_token = prefs.getString('api_token');
  getSharedPrefTimer();

// Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
   // MyApp(id: id, api_token:api_token, intro:intro),
      Provider.value(value: adState,
       builder: (context,child)=>MyApp(id: id, api_token:api_token, intro:intro),
      )
      );
}
class MyApp extends StatelessWidget {
  final String id, api_token;
  bool intro;
  MyApp({this.id, this.intro, this.api_token});

  @override
  Widget build(BuildContext context) {
    print(id.toString());
    print ('api token: $api_token');
    return ChangeNotifierProvider(
      create:(context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'SMS Wallet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.grey,
        ),
        home: //GetKycDetails(),
        SplashScreen(id: id, api_token: api_token, intro:intro),
      )
    );
  }
}
