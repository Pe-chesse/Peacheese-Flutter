import 'package:flutter/material.dart';
import 'package:peach_market/widgets/chat/room_list_tile.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({super.key});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍑 채팅'),
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        // ],
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for(int i = 0; i<20;i++)
            ChatRoomListTile()
          ],
        ),
      ),
    );
  }
}
