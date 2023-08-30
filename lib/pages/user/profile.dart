import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/widgets/bottom_sheet/profile.dart';
import 'package:peach_market/widgets/post/preview.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key, this.nickname});

  final String? nickname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nickname ?? '🍑 내 정보'),
        actions: [
          if (nickname == null)
            IconButton(onPressed: () =>const UserProfileBottomSheet().show(context), icon: const Icon(Icons.more_vert))
        ],
      ),
      body: LayoutBuilder(builder: (context, box) {
        return Scrollbar(
          child: DefaultTabController(
            length: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => context.go('/follow'),
                        child: Column(
                          children: [
                            Text(
                              '2950',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text('followers',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      const UserProfileImageWidget(radius: 36),
                      InkWell(
                        onTap: () => context.go('/follow'),
                        child: Column(
                          children: [
                            Text(
                              '128',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text('followings',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text('행복한 복숭아 농장',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Text(
                    '복숭아 전국 배송, 복숭아 농장 체험, 복숭아 농장',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black45),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.chat_bubble),
                      style: IconButton.styleFrom(
                          side: BorderSide(color: Theme.of(context).focusColor)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(110, 36)),
                    child: const Text('팔로우'),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).focusColor)),
                    child: const Row(
                      children: [
                        Spacer(),
                        TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(icon: Icon(Icons.table_rows)),
                            Tab(icon: Icon(Icons.grid_view_sharp)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: box.maxHeight - 50,
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              const PostPreviewWidget(),
                          separatorBuilder: (context, index) =>
                              const Divider(height: 30),
                        ),
                        GridView.count(
                          padding: const EdgeInsets.all(10),
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 1,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          children: [300, 400, 500, 600]
                              .map((e) => Image.network(
                                  'https://picsum.photos/${e}',
                                  fit: BoxFit.cover))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
