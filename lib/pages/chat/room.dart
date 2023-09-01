import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/providers/chat.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/services/ws.dart';
import 'package:peach_market/widgets/bottom_sheet/chat_room.dart';
import 'package:peach_market/widgets/chat/chat_box_from_me.dart';
import 'package:peach_market/widgets/chat/chat_box_from_user.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  const ChatRoomPage({super.key, required this.name});

  final String name;

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ws.sendMessage(jsonEncode({
      'type': 'active_chat',
      'request': {
        'chat_room': widget.name,
      },
    }));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ws.sendMessage(jsonEncode({
      'type': 'deactive_chat',
      'request': {
        'chat_room': widget.name,
      },
    }));
  }

  void sendMessage() {
    if (textController.text.trim().isEmpty) {
      return;
    }
    ws.sendMessage(jsonEncode({
      'type': 'send_chat',
      'request': {
        'chat_room': widget.name,
      },
      'content': textController.text.trim() //String
    }));
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatroom = ref.watch(chatroomStateNotifierProvider);
    final chatboxMaxWidth = MediaQuery.of(context).size.width - 40 - 48 - 60;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(chatroom.members
            .where((e) =>
                e.nickname != ref.read(userStateNotifierProvider).nickname)
            .map((e) => e.nickname)
            .join(", ")),
        actions: [
          IconButton(
              onPressed: () => ChatRoomBottomSheet(
                    members: chatroom.members,
                  ).show(context),
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // controller: scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: chatroom.messages.reversed
                  .map((e) => e.user.nickname ==
                          ref.read(userStateNotifierProvider).nickname
                      ? ChatBoxFromMeWidget(
                          maxWidth: chatboxMaxWidth,
                          message: e,
                          members: chatroom.members,
                        )
                      : ChatBoxFromUserWidget(
                          maxWidth: chatboxMaxWidth,
                          message: e,
                          members: chatroom.members,
                        ))
                  .toList(),
            ),
          ),
          Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                child: Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: const Color(0xFFC4C4C4),
                    //   foregroundColor: Colors.white,
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(CupertinoIcons.photo),
                    //   ),
                    // ),
                    // const SizedBox(width: 10),
                    Expanded(
                        child: TextFormField(
                      controller: textController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '메세지 입력하기...',
                      ),
                    )),
                    SizedBox(
                      width: 36,
                      child: IconButton(
                          onPressed: () => sendMessage(),
                          icon: const Icon(CupertinoIcons.paperplane_fill)),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
