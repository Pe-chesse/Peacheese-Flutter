// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages


import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/user.dart';

part 'member.g.dart';

@JsonSerializable()
class Member extends User {
  final int? last_read_num;

  Member({
    required String email,
    String? nickname,
    String? image_url,
    this.last_read_num,
  }) : super(
    email: email,
    nickname: nickname,
    image_url: image_url,
  );

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Member copyWith({
    String? email,
    String? nickname,
    String? image_url,
    int? last_read_num,
  }) {
    return Member(
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      image_url: image_url ?? this.image_url,
      last_read_num: last_read_num ?? this.last_read_num,
    );
  }
}
