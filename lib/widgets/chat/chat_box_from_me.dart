import 'package:flutter/material.dart';
import 'package:peach_market/models/message.dart';
import 'package:peach_market/utils/time_ago.dart';

class ChatBoxFromMeWidget extends StatelessWidget {
  const ChatBoxFromMeWidget({super.key,required this.maxWidth,required this.message});

  final Message message;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '1',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                timeAgo(message.time),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 10),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.all(6),
            constraints: BoxConstraints(maxWidth: maxWidth),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)
                    .copyWith(topRight: const Radius.circular(0))),
            child: Text(message.content,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  }
}
