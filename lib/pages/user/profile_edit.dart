import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peach_market/providers/post.dart';
import 'package:peach_market/providers/user.dart';
import 'package:peach_market/services/api.dart';
import 'package:peach_market/widgets/dialog/default.dart';
import 'package:peach_market/widgets/dialog/image_picker.dart';
import 'package:peach_market/widgets/sign/textfield.dart';

class UserProfileEditPage extends ConsumerWidget {
  const UserProfileEditPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController nicknameController = TextEditingController();
    final TextEditingController dioController = TextEditingController();
    final imageKeyState = ref.watch(imageKeyProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text('PROFILE 🍑',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 25),
              IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? images =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (images == null) {
                      return;
                    }
                    var response = await API.bucket.upload([images]);
                    if (response.statusCode == 201) {
                      ref.read(imageKeyProvider.notifier).state =
                          response.data['image_keys'];
                    }
                  },
                  icon: imageKeyState.isEmpty
                      ? const Icon(Icons.add_photo_alternate_outlined)
                      : CircleAvatar(
                          backgroundImage: Image.network(
                                  '${API.BASE_URL}bucket/media/?key=${imageKeyState.first}')
                              .image,
                          radius: 72),
                  iconSize: 72),
              const SizedBox(height: 20),
              CustomTextField.common(
                  '닉네임', const Icon(Icons.person), nicknameController),
              const SizedBox(height: 20),
              CustomTextField.common(
                  '소개', Icon(Icons.description_outlined), dioController),
              const SizedBox(height: 56),
              ElevatedButton(
                onPressed: () async {
                  if(nicknameController.text.trim().isEmpty){
                    return const DefaultMessageDialog(title: '닉네임은 필수항목입니다.').show(context);
                  }
                  var response = await API.account.editProfile({
                    'nickname': nicknameController.text.trim(),
                    'description': dioController.text.trim(),
                    if (imageKeyState.isNotEmpty) 'image_key': imageKeyState.first
                  });
                  ref.read(userStateNotifierProvider.notifier).set(response);
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 44),
                ),
                child: const Text('수정하기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
