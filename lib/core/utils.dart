import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets_constants.dart';

void showSnackBar(BuildContext context, String content) {
  final screenHeight = MediaQuery.of(context).size.height;
  const snackBarHeight = 80.0;
  final topMargin =
      screenHeight - snackBarHeight - MediaQuery.of(context).viewInsets.top-50;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          SvgPicture.asset(
            AssetsConstants.tickIcon,
            width: 25,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(child: Text(content)),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: topMargin, left: 20.0, right: 20.0),
      backgroundColor: const Color.fromRGBO(235, 250, 255, 1),
      dismissDirection: DismissDirection.none,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Set border radius
        side: const BorderSide(
          color: Color.fromRGBO(90, 143, 176, 1), // Set border color
          width: 2.0, // Set border width
        ),
      ),
    ),
  );
}
