import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'assets_constants.dart';

class UIConstants {
  static AppBar appbar(VoidCallback onPressed, bool onHome) {
    return AppBar(
      leading: onHome
          ? IconButton(
              onPressed: onPressed,
              icon: SvgPicture.asset(
                AssetsConstants.emojiIcon,
                height: 20,
                width: 20,
              ),
            )
          : null,
      title: onHome
          ? Image.asset(
              AssetsConstants.shortLogo,
              width: 200,
              height: 150,
            )
          : Center(
              child: Image.asset(
                AssetsConstants.shortLogo,
                width: 100,
                height: 150,
              ),
            ),
    );
  }
}
