import 'package:flutter/material.dart';
import 'package:peach_market/widgets/user/follow_tile.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class UserFollowPage extends StatelessWidget {
  const UserFollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: ListView(
        children: [
          UserFollowTileWidget(),
        ],
      ),
    );
  }
}
