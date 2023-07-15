import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String text;
  const ErrorPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(text: text),
    );
  }
}
