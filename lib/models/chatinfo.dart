// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/roominfo.dart';

part 'chatinfo.g.dart';

@JsonSerializable()
class ChatInfo {
  final List<RoomInfo> data;
  final int unread;

  ChatInfo({
    required this.data,
    required this.unread,
  });

  factory ChatInfo.fromJson(Map<String, dynamic> json) =>
      _$ChatroomFromJson(json);


  ChatInfo copyWith({
    List<RoomInfo>? data,
    int? unread,
  }) {
    return ChatInfo(
      data: data ?? this.data,
      unread: unread ?? this.unread,
    );
  }
}