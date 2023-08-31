import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostWritePage extends ConsumerWidget {
  const PostWritePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final imageKeyState = ref.watch(imageKeyProvider);
    final TextEditingController editingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍑 글 쓰기'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
            ),
            child: const Text('업로드'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ImagePicker picker = ImagePicker();
          final List<XFile> images = await picker.pickMultiImage();
          if (images.isNotEmpty) {
            var response = await API.bucket.upload(images);
            if (response.statusCode == 201) {
              ref.read(imageKeyProvider.notifier).state =
                  response.data['image_keys'];
            }
          }
        },
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.image_outlined, size: 36, color: Colors.white),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserProfileImageWidget(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      minLines: 1,
                      maxLines: 100,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '업로드 할 글을 작성해주세요.'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 48),
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 10,
                  children: imageKeyState
                      .map<Widget>((e) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 128,
                                height: 128,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: Image.network(
                                              '${API.BASE_URL}bucket/media/?key=$e')
                                          .image,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    ref.read(imageKeyProvider.notifier).state =
                                        imageKeyState
                                            .where((element) => element != e)
                                            .toList(),
                                icon: const Icon(Icons.cancel),
                                color: Colors.white,
                              )
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
