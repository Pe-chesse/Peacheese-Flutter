import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/utils/time_ago.dart';
import 'package:peach_market/widgets/post/comment.dart';
import 'package:peach_market/widgets/post/comment_input.dart';
import 'package:peach_market/widgets/post/image_viewer.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostDetailPage extends ConsumerStatefulWidget {
  const PostDetailPage({super.key, required this.id});

  final int id;

  @override
  PostDetailPageState createState() => PostDetailPageState();
}

class PostDetailPageState extends ConsumerState<PostDetailPage> {
  @override
  void initState() {
    super.initState();
    ref.read(postDetailProvider.notifier).fetchPostDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final post = ref.watch(postDetailProvider);
    final user = ref.watch(userStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          if(post.user == user)
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: post.id == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserProfileImageWidget(
                                  imageURL: post.user.image_url),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              post.user.nickname ?? '알 수 없음',
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(timeAgo(post.created_at)),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(post.body),
                                    const SizedBox(height: 10),
                                    if (post.image_url!.isNotEmpty)
                                      ImageViewerWidget(
                                          imageUrl: post.image_url!),
                                    const SizedBox(height: 10),
                                    Text.rich(TextSpan(children: [
                                      const WidgetSpan(
                                          child: Icon(CupertinoIcons.heart,
                                              size: 20),
                                          alignment:
                                              PlaceholderAlignment.middle),
                                      TextSpan(text: ' ${post.like_length}'),
                                    ])),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: post.comment_set!
                                .map<Widget>(
                                    (e) => PostCommentWidget(comment: e))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                CommentInputWidget(postId: post.id)
              ],
            ),
    );
  }
}
