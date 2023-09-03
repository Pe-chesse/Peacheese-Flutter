import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/widgets/bottom_sheet/modal.dart';
import 'package:peach_market/widgets/dialog/post_delete.dart';

class PostBottomSheet extends ModalBottomSheet {
  const PostBottomSheet({super.key,required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: ()=> context.go('/post_write',extra: post),
            title: Text('수정'),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              PostDeleteDialog(post: post,).show(context);
            },
            title: Text('삭제'),
          ),
        ],
      ),
    );
  }
}
