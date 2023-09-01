part of 'roominfo.dart';

RoomInfo _$RoomInfoFromJson(Map<String, dynamic> json) {
  int getUnread(){
    try{
      return json['last_message']['num'] - json['last_read'];
    }catch(e){
      return 0;
    }
  }
  String? getContent(){
    try{
      return json['last_message']['content'];
    }catch(e){
      return '';
    }
  }
  return RoomInfo(
    roomname: json['chat_room'] as String,
    members: List<Member>.from(
      json['members'].map((x) => Member.fromJson(x)).toList(),
    ),
    last_read: json['last_read'] as int,
    unread: getUnread(),
    content: getContent(),
  );
}