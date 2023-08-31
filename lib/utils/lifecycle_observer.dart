import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final void Function(AppLifecycleState state) onStateChanged;

  AppLifecycleObserver({required this.onStateChanged});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onStateChanged(state);
  }
}