import 'package:flutter/material.dart';
import 'package:peach_market/models/comment.dart';
import 'package:peach_market/utils/time_ago.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostCommentWidget extends StatelessWidget {
  const PostCommentWidget({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserProfileImageWidget(
                    radius: 16, imageURL: comment.user.image_url),
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
                            comment.user.nickname ?? '알 수 없음',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          Text(
                            timeAgo(comment.created_at),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(comment.body),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ] +
          comment.child_comments
              .map((e) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: PostCommentWidget(comment: e),
                  ))
              .toList(),
    );
  }
}
