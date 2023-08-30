import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.type,
    required this.icon,
    this.obscureText,
    this.inputFormatter,
    required this.controller,
    this.onChanged,
  });

  final String type;
  final Widget icon;
  final bool? obscureText;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController controller;

  static CustomTextField email(TextEditingController controller) =>
      CustomTextField(
        type: '이메일',
        icon: const Icon(Icons.email_outlined),
        controller: controller,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z@_.]'))
        ],
      );

  static CustomTextField common(
          String type, Widget icon, TextEditingController controller) =>
      CustomTextField(
        type: type,
        icon: icon,
        controller: controller,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Zㄱ-ㅎ가-힣ㅏ-ㅣ .-ㆍ]'))
        ],
      );

  static CustomTextField password(TextEditingController controller) =>
      CustomTextField(
        type: '비밀번호',
        icon: const Icon(Icons.lock_outlined),
        controller: controller,
      );

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisibility = false;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) => widget.onChanged?.call(value),
        onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
        inputFormatters: widget.inputFormatter,
        obscureText: widget.type == '비밀번호' ? !passwordVisibility : false,
        decoration: InputDecoration(
          labelText: widget.type,
          border: InputBorder.none,
          prefixIcon: widget.icon,
          suffixIcon: widget.type == '비밀번호' ? InkWell(
            onTap: () => togglePasswordVisibility(),
            child: Icon(
              passwordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF757575),
              size: 22,
            ),
          ):null,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
