import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class UserLogoutDialog extends DefaultDialog {
  const UserLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(


      title: const Text('로그아웃하시겠어요?'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(
            context,
          ).pop(),
          textStyle: const TextStyle(
              color: Colors.black
          ),
          child: const Text('취소'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(
              context,
            ).pop();
          },
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}
