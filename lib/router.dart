import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/pages/chat/room.dart';
import 'package:peach_market/pages/post/detail.dart';
import 'package:peach_market/pages/post/write.dart';
import 'package:peach_market/pages/sign/login.dart';
import 'package:peach_market/pages/sign/email_sign_in.dart';
import 'package:peach_market/pages/sign/email_sign_up.dart';
import 'package:peach_market/pages/user/follow.dart';
import 'package:peach_market/pages/user/profile_edit.dart';
import 'package:peach_market/widgets/bottom_navigation.dart';

final GoRouter router = GoRouter(
  initialLocation: '/sign',
  observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainBottomNavigation(),
      routes: [
        GoRoute(
          path: 'post_detail',
          builder: (context, state) => const PostDetailPage(),
        ),
        GoRoute(
          path: 'chat_room',
          builder: (context, state) => const ChatRoomPage(),
        ),
        GoRoute(
          path: 'post_write',
          builder: (context, state) => const PostWritePage(),
        ),
        GoRoute(
          path: 'profile_edit',
          builder: (context, state) => const UserProfileEditPage(),
        ),
        GoRoute(
          path: 'follow',
          builder: (context, state) => const UserFollowPage(),
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
