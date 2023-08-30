import 'package:flutter/material.dart';
import 'package:peach_market/models/comment.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostCommentWidget extends StatelessWidget {
  const PostCommentWidget({super.key, this.comment});

  final Comment? comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileImageWidget(radius: 16),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '복자네 복숭아',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Text(
                            '4시간 전',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Text('좋은 글귀네요~ 좋아요 누르고 갑니다')
                    ],
                  ),
                ),
              ],
            ),
          ] +
          comment!.child_comments
              .map((e) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: PostCommentWidget(comment: e),
                  ))
              .toList(),
    );
  }
}
