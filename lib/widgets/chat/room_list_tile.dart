import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/models/member.dart';
import 'package:peach_market/models/roominfo.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/utils/chat_thumbnail.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class ChatRoomListTile extends ConsumerWidget {
  const ChatRoomListTile({super.key, required this.roomInfo});

  final RoomInfo roomInfo;

  Widget listTileAvatar(List<Member> member) {
    double getAvatarScale(int n) {
      switch (n) {
        case 1:
          return 24;
        case 2:
          return 18;
        case 3:
          return 14;
        default:
          return 12;
      }
    }

    List<Offset> widgetPos = calculatePoints(member.length);
    if (widgetPos.length == 1) {
      return UserProfileImageWidget(
        user: member.first,
      );
    } else {
      return Stack(
        children: member
            .asMap()
            .entries
            .map((e) => Align(
                  alignment: Alignment(
                    widgetPos[e.key].dx,
                    widgetPos[e.key].dy,
                  ),
                  child: UserProfileImageWidget(
                      radius: getAvatarScale(member.length), user: e.value),
                ))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      onTap: () => context.go('/chatroom', extra: roomInfo.roomname),
      leading: SizedBox(
        width: 48,
        height: 48,
        child: listTileAvatar(roomInfo.members
            .where((element) =>
                element.nickname !=
                ref.read(userStateNotifierProvider).nickname)
            .toList()),
      ),
      title: Text(roomInfo.members
          .where((element) =>
              element.nickname != ref.read(userStateNotifierProvider).nickname)
          .map((e) => e.nickname)
          .join(", ")),
      subtitle: Text(roomInfo.content ?? '', maxLines: 1),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          if (roomInfo.unread > 0)
            CircleAvatar(
              radius: 12,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                '${roomInfo.unread}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          const Spacer(),
          // Text(timeAgo(roomInfo.time)),
        ],
      ),
    );
  }
}
