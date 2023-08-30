import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SociaLoginButton extends StatelessWidget {
  const SociaLoginButton(
      {super.key,
      required this.backgroundColor,
      required this.foregroundColor,
        this.side,
      required this.onTap,
      required this.platform});

  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? side;
  final String platform;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>onTap.call(),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: side,
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          textStyle:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/images/platform_${platform == "구글"? "google":"apple"}.svg',
            width: 30,
          ),
          Text('$platform 계정으로 로그인'),
          const SizedBox(width: 24)
        ],
      ),
    );
  }
}
