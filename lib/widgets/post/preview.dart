import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/widgets/bottom_sheet/post.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostPreviewWidget extends StatelessWidget {
  const PostPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => context.go('/post_detail'),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileImageWidget(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text('행복한 복숭아 농장행복한 복숭아 농장행복한 복숭아 농장123',
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text('3일 전'),
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: IconButton(
                          onPressed: ()=>const PostBottomSheet().show(context),
                          padding: EdgeInsets.all(0),
                          icon: const Icon(Icons.more_vert),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('벌써 복숭아의 계절이네요\n오늘 수확한 복숭아가 너무 좋아요 ~'),
                  const SizedBox(height: 10),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image:
                              Image.network('https://picsum.photos/200/300').image,
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text.rich(TextSpan(children: [
                    WidgetSpan(
                        child: Icon(CupertinoIcons.heart, size: 20),
                        alignment: PlaceholderAlignment.middle),
                    TextSpan(text: ' 30    '),
                    WidgetSpan(
                        child: Icon(CupertinoIcons.chat_bubble_text, size: 20),
                        alignment: PlaceholderAlignment.middle),
                    TextSpan(text: ' 18'),
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
