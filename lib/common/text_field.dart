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
          hintStyle: TextStyle(fontSize: 18, color: textColor.withOpacity(0.7)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: textColor),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: hintText),
    );
  }
}
