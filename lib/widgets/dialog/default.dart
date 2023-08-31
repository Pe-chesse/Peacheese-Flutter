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
class DefaultMessageDialog extends DefaultDialog {
  const DefaultMessageDialog({super.key,required this.title,this.content});
  final String title;
  final Widget? content;

  Future<void> show(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: content,
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(
            context,
          ).pop(),
          textStyle: const TextStyle(
              color: Colors.black
          ),
          child: const Text('확인'),
        )
      ],
    );
  }
}
