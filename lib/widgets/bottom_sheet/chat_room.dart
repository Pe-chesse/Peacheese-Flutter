import 'package:flutter/material.dart';
import 'package:peach_market/widgets/bottom_sheet/modal.dart';
import 'package:peach_market/widgets/dialog/chat_room_exit.dart';
import 'package:peach_market/widgets/dialog/chat_room_user_list.dart';

class ChatRoomBottomSheet extends ModalBottomSheet {
  const ChatRoomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              const ChatRoomUserListDialog(members: [],).show(context);
            },
            title: const Text('참여자 보기'),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              const ChatRoomExitDialog().show(context);
            },
            title: const Text('채팅방 나가기'),
          ),
        ],
      ),
    );
  }
}
