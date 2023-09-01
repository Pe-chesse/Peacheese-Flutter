part of 'chatinfo.dart';

ChatInfo _$ChatroomFromJson(Map<String, dynamic> json) {
  List<RoomInfo> data = json['data'].map<RoomInfo>((x) => RoomInfo.fromJson(x)).toList() ;
  int unread = data.map((e) => e.unread).fold(0, (previousValue, element) => previousValue + element);

  return ChatInfo(
    data: data,
    unread: unread
  );
}