part of 'post.dart';

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    body: json['body'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    image_url: (json['image_url'] as List<dynamic>?)?.map((e) => e as String).toList()??[],
    updated_at: DateTime.parse(json['updated_at'] as String),
    created_at: DateTime.parse(json['created_at'] as String),
    comment_set: (json['comment_set'] as List<dynamic>?)
        ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList()??[],
    comment_length: json['comment_length'] as int?,
    like_length: json['like_length'] as int,
    is_like: json['is_like'] as bool,
  );
}