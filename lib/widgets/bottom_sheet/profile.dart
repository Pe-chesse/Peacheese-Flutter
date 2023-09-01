import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/widgets/bottom_sheet/modal.dart';
import 'package:peach_market/widgets/dialog/user_logout.dart';

class UserProfileBottomSheet extends ModalBottomSheet {
  const UserProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              return context.go('/profile_edit');
            },
            title: Text('프로필 수정'),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              const UserLogoutDialog().show(context);
            },
            title: Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}
