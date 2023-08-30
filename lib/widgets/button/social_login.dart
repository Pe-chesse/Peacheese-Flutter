import 'package:flutter/material.dart';

class SociaLoginButton extends StatelessWidget {
  const SociaLoginButton(
      {super.key,
      required this.color,
      required this.onTap,
      required this.icon,
      required this.platform});

  final Color color;
  final String platform;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>onTap.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text('$platform 계정으로 로그인',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color)),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
