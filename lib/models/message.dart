// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int num;
  final String chat_room;
  final User user;
  final DateTime time;

  Message({
    required this.num,
    required this.chat_room,
    required this.user,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}