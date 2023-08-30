// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/user.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final String body;
  final User user;
  final List<Comment> child_comments;
  final DateTime updated_at;
  final DateTime created_at;

  Comment({
    required this.id,
    required this.body,
    required this.user,
    required this.child_comments,
    required this.updated_at,
    required this.created_at,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}