import 'package:flutter/material.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class ChatBoxFromUserWidget extends StatelessWidget {
  const ChatBoxFromUserWidget({super.key, required this.maxWidth});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserProfileImageWidget(radius: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 4, 0),
              padding: const EdgeInsets.all(6),
              constraints: BoxConstraints(maxWidth: maxWidth),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Theme.of(context).focusColor),
                  borderRadius: BorderRadius.circular(10)
                      .copyWith(topLeft: const Radius.circular(0))),
              child: const Text('변명 중에서도 가장 어리석고 못난 변명은 “시간이 없어서"라는 변명이다.'),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
      ],
    );
  }
}
