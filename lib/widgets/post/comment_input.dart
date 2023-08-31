import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class CommentInputWidget extends ConsumerStatefulWidget {
  const CommentInputWidget({super.key,required this.postId});
  final int postId;

  @override
  CommentInputWidgetState createState() => CommentInputWidgetState();
}

class CommentInputWidgetState extends ConsumerState<CommentInputWidget> {
  final TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final comment = ref.watch(commentSelectProvider);
    final commentNotifier = ref.read(commentSelectProvider.notifier);
    return
      Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Theme.of(context).focusColor))),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(comment.id != 0)
                Chip(
                  label: Text('댓글: ${comment.user.nickname}'),
                  deleteIcon: const Icon(Icons.cancel, size: 16),
                  onDeleted: () =>commentNotifier.init(),
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: editingController,
                          minLines: 1,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '댓글 입력하기...',
                          ),
                        )),
                    SizedBox(
                      width: 36,
                      child: IconButton(
                          onPressed: () async{
                            if(editingController.text.isEmpty){
                              return const DefaultMessageDialog(title: '내용을 입력해주세요.').show(context);
                            }
                            if(comment.id == 0){
                              await API.post.writeComment(widget.postId, editingController.text);
                            }else{
                              await API.post.reWriteComment(comment.id, editingController.text);
                            }
                            editingController.clear();
                            commentNotifier.init();
                            ref.read(postDetailProvider.notifier).fetchPostDetail(widget.postId);
                          }, icon: const Icon(Icons.edit)),
                    ),
                  ],
                ),
              ],
            ),
          ));
  }
}
