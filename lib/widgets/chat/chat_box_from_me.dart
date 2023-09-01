import 'package:flutter/material.dart';
import 'package:peach_market/models/member.dart';
import 'package:peach_market/models/message.dart';
import 'package:peach_market/utils/time_ago.dart';

class ChatBoxFromMeWidget extends StatelessWidget {
  const ChatBoxFromMeWidget(
      {super.key,
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
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
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
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(4, 4, 0, 4),
          padding: const EdgeInsets.all(6),
          constraints: BoxConstraints(maxWidth: maxWidth),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)
                  .copyWith(topRight: const Radius.circular(0))),
          child: Text(
            message.content,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
