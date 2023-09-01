import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peach_market/firebase_options.dart';

class FCMManager {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'peacheese', // id
    '🍑 Peacheese', // title
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
    enableLights: true,
  );

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  FCMManager() {
    initializeFCM();
  }

  Future<void> initializeFCM() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    } else {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(sound: true, alert: true, badge: true);
    }

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> onFCMHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await fcmPlugin();
  }

  Future<void> fcmPlugin() async {
    // Your fcmPlugin code goes here
  }

  void loadFCMListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      var androidNotiDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
      );
      var iOSNotiDetails = const DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true);
      var details =
      NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          details,
        );
      }
      await onFCMHandler(message);
    });
    FirebaseMessaging.onBackgroundMessage(onFCMHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
    });
  }
}
