import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  const AuthField(
      {super.key,
      required this.isPassword,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 18),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Pallete.blueColor, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Pallete.greyColor),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: hintText),
    );
  }
}
