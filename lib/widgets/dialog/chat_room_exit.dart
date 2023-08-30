import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class ChatRoomExitDialog extends DefaultDialog {
  const ChatRoomExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(


      title: const Text('채팅방에서 나가시겠어요?'),
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
          child: const Text('나가기'),
        ),
      ],
    );
  }
}
