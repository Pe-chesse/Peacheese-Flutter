part of 'comment.dart';

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int,
    body: json['body'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    child_comments: (json['child_comments'] as List<dynamic>)
        .map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList(),
    updated_at: DateTime.parse(json['updated_at'] as String),
    created_at: DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'user': instance.user.toJson(),
  'child_comments': instance.child_comments.map((e) => e.toJson()).toList(),
  'updated_at': instance.updated_at.toIso8601String(),
  'created_at': instance.created_at.toIso8601String(),
};