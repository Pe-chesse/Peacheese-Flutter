import 'package:flutter/material.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/widgets/user/follow_tile.dart';

class UserFollowPage extends StatelessWidget {
  const UserFollowPage({super.key,required this.follower});
  final bool follower;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
      ),
      body: ListView(
        children: [
          UserFollowTileWidget(user: [] as User),
        ],
      ),
    );
  }
}
