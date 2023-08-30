// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String? nickname;
  final String? image_url;

  User({
    required this.email,
    this.nickname,
    this.image_url,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}