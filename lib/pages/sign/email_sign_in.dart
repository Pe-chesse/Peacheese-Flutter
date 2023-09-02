import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peach_market/services/firebase/auth.dart';
import 'package:peach_market/widgets/sign/textfield.dart';

class SignInEmailPage extends StatefulWidget {
  const SignInEmailPage({super.key});

  @override
  State<SignInEmailPage> createState() => _SignInEmailPageState();
}

class _SignInEmailPageState extends State<SignInEmailPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이메일로 로그인'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text('LOGIN 🍑',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 25),
              Text(
                '이메일과 비밀번호를 입력해주세요.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
              const SizedBox(height: 30),
              CustomTextField.email(emailController),
              const SizedBox(height: 20),
              CustomTextField.password(passwordController),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>context.go('/sign/email_sign_up'),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async => await PeacheeseFirebaseAuth.emailSignIn(context, emailController.text, passwordController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 44),
                ),
                child: const Text('로그인'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
