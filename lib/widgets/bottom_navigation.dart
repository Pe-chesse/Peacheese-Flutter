import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/pages/post/home.dart';
import 'package:peach_market/pages/chat/main.dart';
import 'package:peach_market/pages/user/profile.dart';
import 'package:peach_market/providers/chat.dart';

final bottomNavigationProvider = StateProvider.autoDispose((ref) => 0);

class MainBottomNavigation extends ConsumerStatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  MainBottomNavigationState createState() => MainBottomNavigationState();
}

class MainBottomNavigationState extends ConsumerState<MainBottomNavigation> {
  final tabs = <Widget>[
    const HomePage(),
    const ChatMainPage(),
    Container(),
    const UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final pageState = ref.watch(bottomNavigationProvider);
    final chatState = ref.watch(chatinfoStateNotifierProvider);
    return Scaffold(
        body: tabs[pageState],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageState,
          onTap: (value) {
            if (value == 2) {
              context.go('/post_write');
            } else {
              ref.read(bottomNavigationProvider.notifier).state = value;
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).hintColor,
          showUnselectedLabels: true,
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          items: [
            BottomNavigationBarItem(
                icon: Icon(pageState == 0
                    ? CupertinoIcons.house_fill
                    : CupertinoIcons.house),
                label: '홈'),
            BottomNavigationBarItem(
                icon: Badge(
                  label: Text('${chatState.unread}'),
                  isLabelVisible: chatState.unread != 0,
                  child: Icon(pageState == 1
                      ? CupertinoIcons.chat_bubble_fill
                      : CupertinoIcons.chat_bubble),
                ),
                label: '채팅'),
            const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.plus_app), label: '게시물 작성'),
            BottomNavigationBarItem(
                icon: Icon(pageState == 3
                    ? CupertinoIcons.person_fill
                    : CupertinoIcons.person),
                label: '프로필'),
          ],
        ));
  }
}
