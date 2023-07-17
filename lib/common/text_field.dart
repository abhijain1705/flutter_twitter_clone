import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_clone/theme/pallete.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final bool isPhoneNumber;
  final Color textColor;
  const InputField(
      {super.key,
      this.textColor = Pallete.whiteColor,
      this.isPhoneNumber = false,
      this.isPassword = false,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: textColor),
      controller: controller,
      obscureText: isPassword,
      keyboardType: isPhoneNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isPhoneNumber
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : [], // Only numbers can be entered
      decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 18, color: Pallete.offWhite),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Pallete.whiteColor, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Pallete.whiteColor),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: hintText),
    );
  }
}
