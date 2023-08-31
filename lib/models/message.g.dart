part of 'message.dart';

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    num: json['num'] as int,
    chat_room: json['chat_room'] as String,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    time: DateTime.parse(json['time'] as String),
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'num': instance.num,
  'chat_room': instance.chat_room,
  'content': instance.content,
  'user': instance.user.toJson(),
  'time': instance.time.toIso8601String(),
};