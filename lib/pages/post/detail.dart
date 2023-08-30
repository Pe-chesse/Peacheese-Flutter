import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageProvider = StateProvider.autoDispose((ref) => 0);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
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
                        const UserProfileImageWidget(),
                        const SizedBox(width: 10),
                        Consumer(builder: (context, ref, _) {
                          final PageController pageController = PageController();
                          final pageState = ref.watch(pageProvider);
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '행복한 복숭아 농장행복한 복숭아 농장행복한 복숭아 농장123',
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text('3일 전'),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text('벌써 복숭아의 계절이네요\n오늘 수확한 복숭아가 너무 좋아요 ~'),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        PageView.builder(
                                          onPageChanged: (value) => ref
                                              .read(pageProvider.notifier)
                                              .state = value,
                                          controller: pageController,
                                          clipBehavior: Clip.hardEdge,
                                          itemCount: 3,
                                          itemBuilder: (context, index) =>
                                              Image.network(
                                                  'https://picsum.photos/200/300',
                                                  fit: BoxFit.cover),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0.9),
                                          child: Wrap(
                                            spacing: 6,
                                            children: [0, 0, 0]
                                                .asMap()
                                                .entries
                                                .map((e) => CircleAvatar(
                                                      radius: 4,
                                                      backgroundColor:
                                                          pageState == e.key
                                                              ? Theme.of(context)
                                                                  .colorScheme
                                                                  .primary
                                                              : Colors.white,
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text.rich(TextSpan(children: [
                                  WidgetSpan(
                                      child: Icon(CupertinoIcons.heart, size: 20),
                                      alignment: PlaceholderAlignment.middle),
                                  TextSpan(text: ' 30'),
                                ])),
                                const SizedBox(height: 40),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // PostCommentWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
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
                    Chip(
                      label: Text('댓글: 홍가네 복숭아'),
                      deleteIcon: Icon(Icons.cancel, size: 16),
                      onDeleted: () {},
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
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
                              onPressed: () {}, icon: const Icon(Icons.edit)),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
