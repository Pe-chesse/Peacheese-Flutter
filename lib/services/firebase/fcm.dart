import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/firebase_options.dart';
import 'package:peach_market/providers/chat.dart';

class FCMHandler {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'peacheese',
    'peacheese',
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
    enableLights: true,
  );

  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static bool isFlutterLocalNotificationsInitialized = false;

  static Future initializeFCM() async {
    if (!isFlutterLocalNotificationsInitialized) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );
      if (Platform.isAndroid) {
        final permissionsGranted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestPermission();
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      } else {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(sound: true, alert: true, badge: true);
      }
      isFlutterLocalNotificationsInitialized = true;
    }
  }

  @pragma('vm:entry-point')
  static Future onFCMHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await initializeFCM();

  }

  static void loadFCMListener(WidgetsBindingObserver observer,WidgetRef ref) {
    WidgetsBinding.instance.addObserver(observer);
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
        if(ref.read(chatroomStateNotifierProvider).name != message.data['room_name']){
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            details,
          );
        }
        print(ref.read(chatroomStateNotifierProvider).name);
        print(message.data);
      }
      await onFCMHandler(message);
    });

    FirebaseMessaging.onBackgroundMessage(onFCMHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // Handle the event when a push notification is tapped.
      print(message);
    });
  }
}
