import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/widgets/bottom_sheet/chat_room.dart';
import 'package:peach_market/widgets/chat/chat_box_from_me.dart';
import 'package:peach_market/widgets/chat/chat_box_from_user.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatboxMaxWidth = MediaQuery.of(context).size.width - 40 - 48 - 60;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('행복한 복숭아 농장'),
        actions: [
          IconButton(onPressed: () => const ChatRoomBottomSheet().show(context), icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ChatBoxFromMeWidget(maxWidth: chatboxMaxWidth),
                  ChatBoxFromUserWidget(maxWidth: chatboxMaxWidth)
                ],
              ),
            ),
          ),Container(
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
                          onPressed: () {},
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
