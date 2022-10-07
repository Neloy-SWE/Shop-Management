import 'package:flutter/material.dart';
import '../utilities/colors.dart';

class AllButton {
  static generalButton({
    required BuildContext context,
    required String btnText,
    required Function onTap,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          onTap();
        },
        color: AllColors.primaryColor,
        splashColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        child: Text(
          btnText,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
