import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String label;
  final Icon icon;
  const UserInfo({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(label)
        ],
      ),
    );
  }
}
