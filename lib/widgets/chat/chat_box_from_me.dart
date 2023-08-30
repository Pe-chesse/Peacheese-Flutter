import 'package:flutter/material.dart';

class ChatBoxFromMeWidget extends StatelessWidget {
  const ChatBoxFromMeWidget({super.key,required this.maxWidth});

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
                '12:39',
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
            child: const Text(
              '변명 중에서도 가장 어리석고 못난 변명은 “시간이 없어서"라는 변명이다.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  }
}
