// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/member.dart';
import 'package:peach_market/models/message.dart';
import 'package:peach_market/models/roominfo.dart';

part 'chatroom.g.dart';



@JsonSerializable()
class Chatroom {
  final String name;
  final List<Member> members;
  final List<Message> messages;

  Chatroom({
    required this.name,
    required this.members,
    required this.messages,
  });

  factory Chatroom.fromJson(Map<String, dynamic> json) => _$ChatroomFromJson(json);

  Chatroom copyWith({
    String? name,
    List<Member>? members,
    List<Message>? messages,
  }) {
    return Chatroom(
      name: name ?? this.name,
      members: members ?? this.members,
      messages: messages ?? this.messages,
    );
  }

}

