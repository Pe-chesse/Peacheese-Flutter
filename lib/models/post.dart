// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
import 'package:peach_market/models/comment.dart';
import 'package:peach_market/models/user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final String body;
  final User user;
  final List<String> image_url;
  final DateTime updated_at;
  final DateTime created_at;
  final List<Comment> comment_set;
  final int like_set_length;
  final bool is_like;

  Post({
    required this.id,
    required this.body,
    required this.user,
    required this.image_url,
    required this.updated_at,
    required this.created_at,
    required this.comment_set,
    required this.like_set_length,
    required this.is_like,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
