import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/widgets/bottom_sheet/sign.dart';
import 'package:peach_market/widgets/button/social_login.dart';
import 'package:peach_market/widgets/post/preview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍑 Peacheese'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search))
        ],
      ),
      body: Scrollbar(
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) => const PostPreviewWidget(),
          separatorBuilder: (context, index) => const Divider(height: 30),
        ),
      ),
    );
  }
}
