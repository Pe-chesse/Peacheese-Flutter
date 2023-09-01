import 'package:flutter/material.dart';
import 'package:peach_market/models/member.dart';
import 'package:peach_market/models/message.dart';
import 'package:peach_market/utils/time_ago.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class ChatBoxFromUserWidget extends StatelessWidget {
  const ChatBoxFromUserWidget({super.key,
    required this.maxWidth,
    required this.message,
    required this.members});

  final Message message;
  final List<Member> members;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final int readuser = members.where((e) {
      int n = e.last_read_num ?? 9999;
      return n < message.num;
    }).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileImageWidget(radius: 16, user: message.user),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8, 4, 4, 4),
              padding: const EdgeInsets.all(6),
              constraints: BoxConstraints(maxWidth: maxWidth),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Theme
                      .of(context)
                      .focusColor),
                  borderRadius: BorderRadius.circular(10)
                      .copyWith(topLeft: const Radius.circular(0))),
              child: Text(message.content),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(readuser > 0)Text(
                  '$readuser',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    fontSize: 10,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                  ),
                ),
                Text(
                  timeAgo(message.time),
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
