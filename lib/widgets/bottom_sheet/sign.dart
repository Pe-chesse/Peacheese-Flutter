import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/services/firebase/auth.dart';
import 'package:peach_market/widgets/bottom_sheet/modal.dart';
import 'package:peach_market/widgets/button/social_login.dart';
import 'package:peach_market/widgets/dialog/notice.dart';

class SignBottomSheet extends ModalBottomSheet {
  const SignBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SociaLoginButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).hintColor,
                  side: BorderSide(color: Theme.of(context).hintColor),
                  onTap: () => PeacheeseFirebaseAuth.google(),
                  platform: '구글'),
              if (Platform.isIOS) ...[
                SociaLoginButton(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onTap: () => PeacheeseFirebaseAuth.apple(),
                    platform: '애플'),
                Center(
                    child: TextButton(
                        onPressed: () async{
                          await FirebaseAuth.instance.signOut();
                          context.go('/');
                        },
                        child: const Text('게스트로 둘러보기'))),
              ],
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => context.go('/sign/email_sign_in'),
                    child: Text(
                      '이메일로 로그인',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ),
                  Text('|',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                  TextButton(
                    onPressed: () => context.go('/sign/email_sign_up'),
                    child: Text(
                      '회원가입',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ),
                ],
              ),Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => NoticeMessageDialog(title: '이용약관', content: true).show(context),
                    child: Text(
                      '이용약관',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  Text('|',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                  TextButton(
                    onPressed: () => NoticeMessageDialog(title: '개인정보 처리방침', content: false).show(context),
                    child: Text(
                      '개인정보 처리방침',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      enableDrag: false,
      onClosing: () {},
    );
  }
}
