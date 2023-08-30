import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultDialog extends StatelessWidget {
  const DefaultDialog({super.key});

  Future<void> show(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
