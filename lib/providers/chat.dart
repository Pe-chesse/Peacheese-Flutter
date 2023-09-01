import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/chatinfo.dart';
import 'package:peach_market/models/chatroom.dart';
import 'package:peach_market/models/message.dart';
import 'package:peach_market/models/user.dart';

class ChatroomNotifier extends StateNotifier<Chatroom> {
  ChatroomNotifier() : super(Chatroom(name: '', members: [], messages: []));

  void join(Chatroom chatroom) {
    state = chatroom;
  }

  void addMessage(Message message) {
    state = state.copyWith(
      messages: [...state.messages, message],
    );
  }

  void readUpdate(Map<String, dynamic> data) {
    state = state.copyWith(
        members: state.members
            .map((e) => e.email == data['user']
                ? e.copyWith(last_read_num: data['read'])
                : e)
            .toList());
  }
}

final chatroomStateNotifierProvider =
    StateNotifierProvider.autoDispose<ChatroomNotifier, Chatroom>(
        (ref) => ChatroomNotifier());

class ChatInfoNotifier extends StateNotifier<ChatInfo> {
  ChatInfoNotifier() : super(ChatInfo(data: [], unread: 0));

  void set(ChatInfo value) {
    state = value;
  }

  void readUpdate(Map<String, dynamic> data, User user) {
    state = state.copyWith(
      data: state.data
          .map((e) =>
      e.roomname == data['chat_room'] && user.email == data['user']
          ? e.copyWith(unread: 0, last_read: data['read'])
          : e)
          .toList(),
      unread: state.data
          .map((e) => e.unread)
          .fold(0, (previousValue, element) => previousValue??0 + element)
    );
  }
}

final chatinfoStateNotifierProvider =
    StateNotifierProvider<ChatInfoNotifier, ChatInfo>(
        (ref) => ChatInfoNotifier());
