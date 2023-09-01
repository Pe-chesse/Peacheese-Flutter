import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peach_market/widgets/dialog/default.dart';

class ImagePickerDialog extends DefaultDialog {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(

      title: const Text('이미지 선택'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(
            context,
          ).pop(true),
          textStyle: const TextStyle(
              color: Colors.black
          ),
          child: const Text('갤러리'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(false);
          },
          textStyle: const TextStyle(
              color: Colors.black
          ),
          child: const Text('카메라'),
        ),
      ],
    );
  }
}
