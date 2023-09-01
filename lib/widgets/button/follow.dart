import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/models/user.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/services/api.dart';

class FollowStateButton extends ConsumerWidget {
  const FollowStateButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, ref) {
    final stateNotifier = ref.watch(myFollowProvider.notifier);
    List state = ref.watch(myFollowProvider);
    return ElevatedButton(
      onPressed: () async {
        stateNotifier.state = await API.account.setFollow(user.nickname!);
        state = stateNotifier.state;
        ref.refresh(userProfileProvider(user.nickname!));
      },
      style:
          state.where((element) => element.nickname == user.nickname).isNotEmpty
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).hintColor,
                  side: BorderSide(
                    color: Theme.of(context).hintColor,
                  ),
                  elevation: 0,
                  minimumSize: const Size(110, 36),
                  padding: const EdgeInsets.all(0),
                )
              : ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(110, 36)),
      child: Text(
          state.where((element) => element.nickname == user.nickname).isNotEmpty
              ? '취소'
              : '팔로우'),
    );
  }
}
