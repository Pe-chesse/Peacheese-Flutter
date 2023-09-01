import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/bottom_sheet/profile.dart';
import 'package:peach_market/widgets/button/follow.dart';
import 'package:peach_market/widgets/post/preview.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key, this.nickname});

  final String? nickname;

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(userStateNotifierProvider.notifier).get();
    API.account
        .getFollow(ref.read(userStateNotifierProvider).nickname!, false)
        .then((value) => ref.read(myFollowProvider.notifier).state = value);
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateNotifierProvider);
    final profileState = ref.watch(
        userProfileProvider(widget.nickname ?? userState.nickname ?? ''));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nickname ?? '🍑 내 정보'),
        actions: [
          if (widget.nickname == null)
            IconButton(
                onPressed: () =>
                    const UserProfileBottomSheet().show(context),
                icon: const Icon(Icons.more_vert))
        ],
      ),
      body: profileState.when(
          data: (data) => LayoutBuilder(builder: (context, box) {
            return Scrollbar(
              child: DefaultTabController(
                length: 2,
                child: RefreshIndicator(
                  onRefresh: () async=> ref.refresh(userProfileProvider(widget.nickname ?? userState.nickname ?? '')),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => context.go('/follow', extra: {
                                'follower': true,
                                'nickname': data['user'].nickname
                              }),
                              child: Column(
                                children: [
                                  Text(
                                    '${data['user'].followers}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Text('followers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            ),
                            UserProfileImageWidget(
                                radius: 36, user: data['user']),
                            InkWell(
                              onTap: () => context.go('/follow', extra: {
                                'follower': false,
                                'nickname': data['user'].nickname
                              }),
                              child: Column(
                                children: [
                                  Text(
                                    '${data['user'].followings}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  Text('followings',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(data['user'].nickname,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text(
                          data['user'].description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black45),
                        ),
                        const SizedBox(height: 10),
                        if (data['user'].nickname != userState.nickname)
                        ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: IconButton(
                              onPressed: () async {
                                final response = await API.chat.create(data['user'].nickname);
                                return context.go('/chatroom',extra: response.name);
                              },
                              icon: const Icon(CupertinoIcons.chat_bubble),
                              style: IconButton.styleFrom(
                                  side: BorderSide(
                                      color: Theme.of(context).focusColor)),
                            ),
                          ),
                          FollowStateButton(user: data['user']),
                        ],
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).focusColor)),
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
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 30),
                                itemCount: data['post'].length,
                                itemBuilder: (context, index) =>
                                    PostPreviewWidget(
                                        post: data['post'][index]),
                                separatorBuilder: (context, index) =>
                                const Divider(height: 30),
                              ),
                              GridView.count(
                                padding: const EdgeInsets.all(10),
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: data['post']
                                    .where((e) => e.image_url!.length != 0)
                                    .map<Widget>((e) => InkWell(
                                  onTap: () => context
                                      .go('/post_detail/${e.id}'),
                                  child: Image.network(
                                      e.image_url!.first,
                                      fit: BoxFit.cover),
                                ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          error: (error, stackTrace) =>
              Center(child: Text('$error\n\n$stackTrace')),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
