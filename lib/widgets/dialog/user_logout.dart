import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/services/firebase/auth.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class UserLogoutDialog extends DefaultDialog {
  const UserLogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(


      title: const Text('로그아웃 하시겠어요?'),
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
          onPressed: () async{
            Navigator.of(
              context,
            ).pop();
            await PeacheeseFirebaseAuth.signOut();
          },
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}
