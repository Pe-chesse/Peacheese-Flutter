part of 'post.dart';

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    body: json['body'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    image_url:
    (json['image_url'] as List<dynamic>).map((e) => e as String).toList(),
    updated_at: DateTime.parse(json['updated_at'] as String),
    created_at: DateTime.parse(json['created_at'] as String),
    comment_set: (json['comment_set'] as List<dynamic>)
        .map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList(),
    like_set_length: json['like_set_length'] as int,
    is_like: json['is_like'] as bool,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'body': instance.body,
  'user': instance.user.toJson(),
  'image_url': instance.image_url,
  'updated_at': instance.updated_at.toIso8601String(),
  'created_at': instance.created_at.toIso8601String(),
  'comment_set': instance.comment_set.map((e) => e.toJson()).toList(),
  'like_set_length': instance.like_set_length,
  'is_like': instance.is_like,
};