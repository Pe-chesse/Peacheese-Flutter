import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/utils/time_ago.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostPreviewWidget extends StatelessWidget {
  const PostPreviewWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => context.go('/post_detail/${post.id}'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileImageWidget(user: post.user),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(post.user.nickname ?? '알 수 없음',
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(timeAgo(post.created_at)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(post.body),
                  const SizedBox(height: 10),
                  if (post.image_url!.isNotEmpty)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: Image.network(post.image_url!.first).image,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text.rich(TextSpan(children: [
                    WidgetSpan(
                        child: post.is_like
                            ? const Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                                size: 20,
                              )
                            : const Icon(CupertinoIcons.heart, size: 20),
                        alignment: PlaceholderAlignment.middle),
                    TextSpan(text: ' ${post.like_length}    '),
                    const WidgetSpan(
                        child: Icon(CupertinoIcons.chat_bubble_text, size: 20),
                        alignment: PlaceholderAlignment.middle),
                    TextSpan(text: ' ${post.comment_length}'),
                  ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
