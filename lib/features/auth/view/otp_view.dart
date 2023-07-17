import 'package:flutter/material.dart';

class OTPView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const OTPView(),
      );
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("hello")),
    );
  }
}
