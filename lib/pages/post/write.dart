import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peach_market/models/post.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/dialog/default.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostWritePage extends ConsumerWidget {
  const PostWritePage({super.key,this.post});
  final Post? post;

  @override
  Widget build(BuildContext context, ref) {
    final imageKeyState = ref.watch(imageKeyProvider);
    print(post);
    final TextEditingController editingController = TextEditingController(text: post?.body??'');
    return Scaffold(
      appBar: AppBar(
        title: Text(post==null?'🍑 글 쓰기':'🍑 글 수정'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (editingController.text.trim().isEmpty) {
                return DefaultMessageDialog(title: '내용을 작성해주세요!').show(context);
              }
              post == null?
              await API.post
                  .writePost(editingController.text.trim(), imageKeyState)
                  .then((postId) => context.go('/post_detail/$postId')):
              await API.post
                  .editPost(post!.id,editingController.text.trim())
                  .then((postId) => context.go('/post_detail/${post!.id}'));

            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
            ),
            child: const Text('업로드'),
          )
        ],
      ),
      floatingActionButton: post == null?FloatingActionButton(
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
      ):null,
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileImageWidget(user: ref.read(userStateNotifierProvider)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: editingController,
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
