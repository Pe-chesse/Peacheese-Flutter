import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/providers/chat.dart';
import 'package:peach_market/widgets/chat/room_list_tile.dart';

class ChatMainPage extends ConsumerWidget {
  const ChatMainPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(chatinfoStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍑 채팅'),
        // actions: [
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        // ],
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) =>
                ChatRoomListTile(roomInfo: state.data[index])),
      ),
    );
  }
}
