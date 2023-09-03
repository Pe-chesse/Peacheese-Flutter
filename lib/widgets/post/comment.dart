import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/comment.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/utils/time_ago.dart';
import 'package:peach_market/widgets/dialog/comment_delete.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostCommentWidget extends ConsumerWidget {
  const PostCommentWidget({super.key, required this.comment, this.isChild});

  final Comment comment;
  final bool? isChild;

  @override
  Widget build(BuildContext context, ref) {
    final selectComment = ref.watch(commentSelectProvider);
    final selectCommentNotifier = ref.read(commentSelectProvider.notifier);
    final userState = ref.read(userStateNotifierProvider);
    return Container(
      padding: isChild == true
          ? const EdgeInsets.fromLTRB(4, 4, 0, 0)
          : const EdgeInsets.only(bottom: 20),
      margin: isChild == true ? const EdgeInsets.only(left: 16) : null,
      decoration: isChild == true
          ? const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey, width: 1)))
          : null,
      child: Column(
        children: <Widget>[
              InkWell(
                child: Container(
                  decoration: selectComment == comment
                      ? BoxDecoration(color: Theme.of(context).primaryColor)
                      : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 2,
                        color: Colors.black,
                      ),
                      UserProfileImageWidget(radius: 16, user: comment.user),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () => selectCommentNotifier.select(comment),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    comment.user.nickname ?? '알 수 없음',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const Spacer(),
                                  Text(
                                    timeAgo(comment.created_at),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  if(userState.nickname == comment.user.nickname)
                                  SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: IconButton(
                                        onPressed: () async=> await CommentDeleteDialog(comment: comment,ref: ref).show(context),
                                        icon: const Icon(Icons.cancel, size: 16),
                                        padding: const EdgeInsets.all(0),
                                      ))
                                ],
                              ),
                              Text(comment.body)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] +
            comment.child_comments
                .map((e) => PostCommentWidget(
                      comment: e,
                      isChild: true,
                    ))
                .toList(),
      ),
    );
  }
}
