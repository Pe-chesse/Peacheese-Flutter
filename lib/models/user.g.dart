part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    nickname: json['nickname'] as String?,
    image_url: json['image_url'] as String?,
    description: json['description'] as String?,
    followings: json['followings_length'] as int?,
    followers: json['followers_length'] as int?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'nickname': instance.nickname,
  'image_url': instance.image_url,
  'description': instance.description,
};