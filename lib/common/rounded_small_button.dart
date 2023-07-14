import 'package:flutter/material.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/theme/pallete.dart';

class RoundedSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool loading;
  const RoundedSmallButton(
      {super.key,
      required this.onTap,
      this.loading = false,
      required this.label,
      this.backgroundColor = Pallete.whiteColor,
      this.textColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Stack(
          children: [
            Visibility(
              visible: !loading,
              child: Text(
                label,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            Visibility(
              visible: loading,
              child: const Loader(),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
      ),
    );
  }
}
