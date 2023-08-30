import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  ModalBottomSheet show(BuildContext context,{bool? drag}) {
    showModalBottomSheet(
      enableDrag: drag??true,
        context: context,
        builder: (context) => this
    );
    return this;
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}