import 'package:flutter/material.dart';
import 'package:peach_market/router.dart';
import 'package:peach_market/style/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '복숭아 마켓',
      routerConfig: router,
      theme: themeData(context),
    );
  }
}