import 'package:flutter/material.dart';
import 'package:peach_market/widgets/user/profile_image.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({super.key});

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  @override
  Widget build(BuildContext context) {
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
        onPressed: () {},
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
                  children: [
                    for (int i = 0; i < 20; i++)
                      Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image:
                                  Image.network('https://picsum.photos/200/300')
                                      .image,
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
