import 'package:flutter/material.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class UserFollowTileWidget extends StatelessWidget {
  const UserFollowTileWidget({super.key});

  Widget followButton(BuildContext context,bool follow){
    if(follow){
      return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).hintColor,
            side: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            elevation: 0,
            fixedSize: const Size(76, 36),
            padding: const EdgeInsets.all(0),
          ),
          child: const Text('취소'));
    }
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        fixedSize: const Size(76, 36),
        padding: const EdgeInsets.all(0),
        elevation: 0,
      ),
      child: const Text('팔로우'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const UserProfileImageWidget(),
      title: Text('복숭아집 밤비네',style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(
        '전국 택배 배송 가능한 복숭아 어쩌구 저쩌구 전국 택배 배송 가능한 복숭아 어쩌구 저쩌구 전국 택배 배송 가능한 복숭아 어쩌구 저쩌구 ',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Theme.of(context).hintColor),
      ),
      trailing: followButton(context,true),
    );
  }
}
