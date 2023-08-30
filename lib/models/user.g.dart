part of 'user.dart';

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    nickname: json['nickname'] as String?,
    image_url: json['image_url'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'email': instance.email,
  'nickname': instance.nickname,
  'image_url': instance.image_url,
};