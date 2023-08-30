// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/member.dart';
import 'package:peach_market/models/message.dart';
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
}