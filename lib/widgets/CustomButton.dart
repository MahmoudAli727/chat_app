// ignore_for_file: file_names, non_constant_identifier_names

import 'package:chat_app/const.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.Button, required this.onTap});
  final String? Button;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: 50,
        width: double.infinity,
        child: Text(
          Button!,
          style: const TextStyle(color: KprimaryColor, fontSize: 20),
        ),
      ),
    );
  }
}
