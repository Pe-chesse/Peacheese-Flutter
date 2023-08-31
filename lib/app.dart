import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/router.dart';
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
    FirebaseAuth.instance.authStateChanges().listen((user) async{
      if(user == null){
        return router.go('/sign');
      }
      if(user.isAnonymous){
        return router.go('/');
      }
      if(!user.emailVerified){
        return await FirebaseAuth.instance.signOut();
      }
      router.go('/');
    });
    WidgetsBinding.instance.addObserver(AppLifecycleObserver(
      onStateChanged: (state) {
        if (state == AppLifecycleState.resumed) {
        } else {
        }
      },
    ));
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