import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/models/user.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({super.key, required this.user, this.radius});

  final User user;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>user.nickname != null?context.go('/profile/',extra: user.nickname):null,
      child: CircleAvatar(
          radius: radius,
          backgroundImage: user.image_url?.isEmpty??true
              ? Image.asset('assets/images/default_user_profile_img.png').image
              : Image.network(user.image_url!).image),
    );
  }
}
