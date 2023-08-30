import 'package:flutter/material.dart';
import 'package:peach_market/widgets/bottom_sheet/sign.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(flex: 1),
            Image.asset('assets/images/logo.png', width: 168),
            Text(
              'Peacheese',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
      bottomSheet: const SignBottomSheet(),
    );
  }
}
