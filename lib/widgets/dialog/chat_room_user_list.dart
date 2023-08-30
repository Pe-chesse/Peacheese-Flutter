import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/widgets/dialog/default.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class ChatRoomUserListDialog extends DefaultDialog {
  const ChatRoomUserListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('채팅방 참여자'),
      actions: [

        for(int i = 0; i<5; i++)
          Container(
            padding: const EdgeInsets.all(10),
            child: const Row(
                children: [
                  UserProfileImageWidget(),
                  SizedBox(width: 10),
                  Expanded(child: Text('닉네임')),
                ]
            ),
          ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(
            context,
          ).pop(),
          textStyle: const TextStyle(color: Colors.black),
          child: const Text('확인'),
        ),
      ],
    );
  }
}
