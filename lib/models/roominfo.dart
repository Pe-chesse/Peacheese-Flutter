// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/member.dart';

part 'roominfo.g.dart';

@JsonSerializable()
class RoomInfo {
  final String roomname;
  final int last_read;
  final int unread;
  final String? content;
  final List<Member> members;

  RoomInfo({
    required this.roomname,
    required this.members,
    required this.last_read,
    required this.unread,
    this.content,
  });

  factory RoomInfo.fromJson(Map<String, dynamic> json) =>
      _$RoomInfoFromJson(json);
}