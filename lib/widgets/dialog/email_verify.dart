import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class EmailVerifyDialog extends DefaultDialog {
  const EmailVerifyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('이메일 미인증'),
      content: Text(
          '${FirebaseAuth.instance.currentUser?.email}\n인증요청을 전송했습니다\n\n메일 내부의 링크를 클릭하시면 인증이 완료됩니다.'),
      actions: [
        CupertinoDialogAction(
          onPressed: () async {
            Navigator.of(
              context,
            ).pop();
            await FirebaseAuth.instance.currentUser
                ?.sendEmailVerification()
                .then(
                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '이메일이 재발송되었습니다.',
                      ),
                    ),
                  ),
                );
          },
          textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          child: const Text('인증메일 재발송'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(
              context,
            ).pop();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
