import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/widgets/post/preview.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postlistProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('🍑 Peacheese'),
          actions: [
            IconButton(
                onPressed: () =>context.go('/search'), icon: const Icon(CupertinoIcons.search))
          ],
        ),
        body: state.when(
            data: (data) => Scrollbar(
                  child: RefreshIndicator(
                    onRefresh: () async =>ref.refresh(postlistProvider),
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) =>
                          PostPreviewWidget(post: data[index]),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 30),
                    ),
                  ),
                ),
            error: (error, stackTrace) =>  Center(child: Text('$error')),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            )));
  }
}
