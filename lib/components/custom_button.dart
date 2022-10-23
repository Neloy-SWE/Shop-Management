import 'package:flutter/material.dart';
import 'package:shop_management/components/custom_loader.dart';
import '../utilities/colors.dart';

class AllButton {
  static generalButton({
    required BuildContext context,
    required String btnText,
    required Function onTap,
    required bool enable,
  }) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          enable ? null : onTap();
        },
        color: AllColors.primaryColor,
        splashColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        child: enable
            ? AllLoader.generalLoader(loaderColor: Colors.white)
            : Text(
                btnText,
                style: Theme.of(context).textTheme.headline3,
              ),
      ),
    );
  }
}
