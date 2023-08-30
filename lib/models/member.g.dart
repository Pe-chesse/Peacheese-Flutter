part of 'member.dart';

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    email: json['user_email'] as String,
    nickname: json['user_nickname'] as String?,
    image_url: json['user_image_url'] as String?,
    last_read_num: json['last_read_num'] as int?,
  );
}
