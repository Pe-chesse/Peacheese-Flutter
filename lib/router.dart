import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/pages/chat/room.dart';
import 'package:peach_market/pages/post/detail.dart';
import 'package:peach_market/pages/post/write.dart';
import 'package:peach_market/pages/sign/login.dart';
import 'package:peach_market/pages/sign/email_sign_in.dart';
import 'package:peach_market/pages/sign/email_sign_up.dart';
import 'package:peach_market/pages/user/follow.dart';
import 'package:peach_market/pages/user/profile.dart';
import 'package:peach_market/pages/user/profile_edit.dart';
import 'package:peach_market/pages/user/search.dart';
import 'package:peach_market/widgets/bottom_navigation.dart';

final GoRouter router = GoRouter(
  initialLocation: '/sign',

  observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  redirect: (BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null && !(['/','/sign'].contains(state.uri.toString())||state.uri.toString().replaceAll('/', '').startsWith('post_detail'))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('로그인이 필요한 서비스입니다.\n로그인 해주세요.')));
        return '/sign';
    }
      return null;
  },


  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainBottomNavigation(),
      routes: [
        GoRoute(
          path: 'post_detail/:id',
          builder: (context, state) {
            return PostDetailPage(id: int.parse(state.pathParameters['id']!));
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            final nickname = state.extra as String;
            return UserProfilePage(nickname: nickname);
          },
        ),
        GoRoute(
          path: 'post_write',
          builder: (context, state) => const PostWritePage(),
        ),
        GoRoute(
          path: 'search',
          builder: (context, state) => UserSearchPage(),
        ),
        GoRoute(
          path: 'profile_edit',
          builder: (context, state) => const UserProfileEditPage(),
        ),
        GoRoute(
          path: 'follow',
          builder: (context, state) {
            final extra = state.extra as Map<String,dynamic>;
            return UserFollowPage(follower: extra['follower'], nickname: extra['nickname'],);
          },
        ),
        GoRoute(
          path: 'chatroom',
          builder: (context, state) {
            final extra = state.extra as String;
            return ChatRoomPage(name: extra);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/sign',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: 'email_sign_in',
          builder: (context, state) => const SignInEmailPage(),
        ),
        GoRoute(
          path: 'email_sign_up',
          builder: (context, state) => const SignUpEmailPage(),
        ),
      ],
    ),
  ],
);
