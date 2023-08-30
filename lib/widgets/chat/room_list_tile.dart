import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/utils/chat_thumbnail.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class ChatRoomListTile extends StatelessWidget {
  const ChatRoomListTile({super.key});
  Widget listTileAvatar(List member) {
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
      return const UserProfileImageWidget();
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
              radius: getAvatarScale(member.length)),
        ))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>context.go('/chat_room'),
      leading: SizedBox(
        width: 48,
        height: 48,
        child: listTileAvatar([0, 0]),
      ),
      title: const Text('행복한 복숭아 농장'),
      subtitle: const Text('제발 헛소리좀 하지마세요...', maxLines: 1),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          CircleAvatar(
            radius:12,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              '1',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
          const Spacer(),
          const Text('2시간 전'),
        ],
      ),
    );
  }
}
