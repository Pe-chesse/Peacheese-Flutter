import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/chatinfo.dart';
import 'package:peach_market/models/chatroom.dart';
import 'package:peach_market/models/message.dart';
import 'package:peach_market/providers/chat.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/router.dart';
import 'package:peach_market/services/ws.dart';
import 'package:peach_market/style/theme.dart';
import 'package:peach_market/utils/lifecycle_observer.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        return router.go('/sign');
      }
      if (user.isAnonymous) {
        return router.go('/');
      }
      if (!user.emailVerified) {
        return await FirebaseAuth.instance.signOut();
      }
      await ref.read(userStateNotifierProvider.notifier).get();
      wsConnect();
      if (ref.read(userStateNotifierProvider).nickname == null) {
        return router.go('/profile_edit');
      }
      router.go('/');
    });
    WidgetsBinding.instance.addObserver(AppLifecycleObserver(
      onStateChanged: (state) {
        if (state == AppLifecycleState.resumed) {
          if (FirebaseAuth.instance.currentUser == null) {
            return;
          }
          wsConnect();
        } else {
          try {
            ws.disconnect();
          } catch (_) {}
        }
      },
    ));
  }

  void wsConnect() {
    ws.connect();
    ws.listen((data) {
      print('$data');
      final socketData = jsonDecode(data);
      switch (socketData['type']) {
        case "sync.message":
          return ref
              .read(chatinfoStateNotifierProvider.notifier)
              .set(ChatInfo.fromJson(socketData));
        case "chat_room.info":
          return ref
              .read(chatroomStateNotifierProvider.notifier)
              .join(Chatroom.fromJson(socketData));
        case "chat.message":
          return ref
              .read(chatroomStateNotifierProvider.notifier)
              .addMessage(Message.fromJson(socketData));
        case "update.read":
          ref
              .read(chatinfoStateNotifierProvider.notifier)
              .readUpdate(socketData, ref.read(userStateNotifierProvider));
          final statenotifier =
              ref.read(chatroomStateNotifierProvider.notifier);
          if (statenotifier.state.name == socketData['chat_room']) {
            statenotifier.readUpdate(socketData);
          }
          return;
        default:
          return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '복숭아 마켓',
      routerConfig: router,
      theme: themeData(context),
    );
  }
}
