import 'package:flutter/material.dart';

class CustomSignNav {
  static signNav({
    required BuildContext context,
    required Function() onTap,
    required String startText,
    required String navText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          startText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            navText,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
