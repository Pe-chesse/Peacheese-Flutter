import 'package:flutter/material.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({super.key, this.imageURL, this.radius});

  final String? imageURL;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundImage: imageURL == null
            ? Image.asset('assets/images/default_user_profile_img.png').image
            : Image.network(imageURL!).image);
  }
}
