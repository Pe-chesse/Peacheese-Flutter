import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageProvider = StateProvider.autoDispose((ref) => 0);

class ImageViewerWidget extends ConsumerWidget {
  const ImageViewerWidget({super.key, required this.imageUrl});

  final List<String> imageUrl;

  @override
  Widget build(BuildContext context, ref) {
    print(imageUrl);
    final PageController pageController = PageController();
    final pageState = ref.watch(pageProvider);
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) =>
                  ref.read(pageProvider.notifier).state = value,
              controller: pageController,
              clipBehavior: Clip.hardEdge,
              itemCount: imageUrl.length,
              itemBuilder: (context, index) =>
                  Image.network(imageUrl[index], fit: BoxFit.cover),
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: Wrap(
                spacing: 6,
                children: imageUrl
                    .asMap()
                    .entries
                    .map((e) => CircleAvatar(
                          radius: 4,
                          backgroundColor: pageState == e.key
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
