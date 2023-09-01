import 'package:flutter/material.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/widgets/button/follow.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class UserFollowTileWidget extends StatelessWidget {
  const UserFollowTileWidget({super.key,required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserProfileImageWidget(user: user),
      title: Text(user.nickname??'알 수 없음',style: Theme.of(context).textTheme.titleMedium,),
      trailing: FollowStateButton(user: user),
    );
  }
}
