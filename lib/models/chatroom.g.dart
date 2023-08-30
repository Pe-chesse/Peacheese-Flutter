part of 'chatroom.dart';

Chatroom _$ChatroomFromJson(Map<String, dynamic> json) {
  return Chatroom(
    members: List<Member>.from(
      json['members'].map((x) => Member.fromJson(x)),
    ),
    messages: List<Message>.from(
      json['messages'].map((x) => Message.fromJson(x)),
    ),
  );
}