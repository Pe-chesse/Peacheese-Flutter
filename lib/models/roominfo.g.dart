part of 'roominfo.dart';

RoomInfo _$RoomInfoFromJson(Map<String, dynamic> json) {
  int getUnread(){
    if(json['last_message']){
      return json['last_message']['num'] - json['last_read'];
    }return 0;
  }
  String? getContent(){
    if(json['last_message']){
      return json['last_message']['content'];
    }return null;
  }
  return RoomInfo(
    roomname: json['name'] as String,
    members: List<Member>.from(
      json['members'].map((x) => Member.fromJson(x)),
    ),
    last_read: json['last_read'] as int,
    unread: getUnread(),
    content: getContent(),
  );
}