import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/app.dart';
import 'package:peach_market/firebase_options.dart';
import 'package:peach_market/services/firebase/fcm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FCMManager fcmManager = FCMManager();
  await fcmManager.initializeFCM();
  fcmManager.loadFCMListener();

  runApp(const ProviderScope(child: App()));
}
