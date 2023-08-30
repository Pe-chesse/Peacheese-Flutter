import 'package:flutter/material.dart';
import 'package:peach_market/widgets/bottom_sheet/modal.dart';
import 'package:peach_market/widgets/dialog/post_delete.dart';

class PostBottomSheet extends ModalBottomSheet {
  const PostBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('수정'),
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
              const PostDeleteDialog().show(context);
            },
            title: Text('삭제'),
          ),
        ],
      ),
    );
  }
}
