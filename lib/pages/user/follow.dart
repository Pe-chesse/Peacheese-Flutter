import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/widgets/user/follow_tile.dart';

class UserFollowPage extends ConsumerWidget {
  const UserFollowPage(
      {super.key, required this.follower, required this.nickname});

  final bool follower;
  final String nickname;

  @override
  Widget build(BuildContext context, ref) {
    final followState = ref.watch(userFollowProvider((nickname, follower)));
    return Scaffold(
      appBar: AppBar(
        title: Text(follower ? 'Followers' : 'Followings'),
      ),
      body: followState.when(
        data: (data) {
          if(data.isEmpty){
            return const Center(child: Text('아무도 없어요.'));
          }
          return ListView.builder(
              itemBuilder: (context, index) =>
                  UserFollowTileWidget(user: data[index]),
              itemCount: data.length);
        },
        error: (error, stackTrace) => Center(child: Text('$stackTrace')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
