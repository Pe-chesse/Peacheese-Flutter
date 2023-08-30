import 'package:flutter/material.dart';
import 'package:peach_market/widgets/sign/textfield.dart';

class UserProfileEditPage extends StatefulWidget {
  const UserProfileEditPage({super.key});

  @override
  State<UserProfileEditPage> createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController dioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Text(
                '나중에 언제든지 변경할 수 있습니다.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 20),
              IconButton(onPressed: (){}, icon: const Icon(Icons.add_photo_alternate_outlined),iconSize: 72),
              const SizedBox(height: 20),
              CustomTextField.common('닉네임',const Icon(Icons.person),nicknameController),
              const SizedBox(height: 20),
              CustomTextField.common('소개',Icon(Icons.description_outlined),dioController),
              const SizedBox(height: 56),
              ElevatedButton(
                onPressed: () {},
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

