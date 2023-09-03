import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/comment.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class CommentDeleteDialog extends DefaultDialog {
  const CommentDeleteDialog({super.key,required this.comment,required this.ref});

  final Comment comment;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(

      title: const Text('댓글을 삭제할까요?'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(
            context,
          ).pop(),
          textStyle: const TextStyle(
            color: Colors.black
          ),
          child: const Text('취소'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () async{
            await API.post.deleteComment(comment.id);
            final notifier = ref.read(postDetailProvider.notifier);
            notifier.fetchPostDetail(notifier.state.id);
            Navigator.of(
              context,
            ).pop();
          },
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
