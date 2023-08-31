import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/widgets/post/preview.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(postlistProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('🍑 Peacheese'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.search))
          ],
        ),
        body: state.when(
            data: (data) => Scrollbar(
                  child: ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        PostPreviewWidget(post: data[index]),
                    separatorBuilder: (context, index) =>
                        const Divider(height: 30),
                  ),
                ),
            error: (error, stackTrace) =>  Center(child: Text('$error')),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            )));
  }
}
