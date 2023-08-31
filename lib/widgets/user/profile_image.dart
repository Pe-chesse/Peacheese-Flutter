import 'package:flutter/material.dart';
import 'package:peach_market/models/user.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({super.key, required this.user, this.radius});

  final User user;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundImage: user.image_url?.isEmpty??true
            ? Image.asset('assets/images/default_user_profile_img.png').image
            : Image.network(user.image_url!).image);
  }
}
