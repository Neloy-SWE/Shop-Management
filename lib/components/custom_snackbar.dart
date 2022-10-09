import 'package:flutter/material.dart';
import 'package:shop_management/utilities/colors.dart';

import '../utilities/all_text.dart';
import '../utilities/app_size.dart';


class CustomSnackBar {
  final BuildContext? context;
  final String? message;
  final bool? isSuccess;

  CustomSnackBar({
    this.context,
    this.message,
    this.isSuccess,
  });

  show() {
    ScaffoldMessenger.of(context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context!).size.height * 0.85),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            isSuccess! ? AllColors.primaryColor : AllColors.errorColor,
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSuccess! ? AllColors.successColor : AllColors.failColor,
              ),
              child: Icon(
                isSuccess! ? Icons.check : Icons.cancel,
                size: 20,
                color: isSuccess!?  Colors.white : Colors.black,
              ),
            ),
            Gap.gapW10,

            FittedBox(
                child: Text(message != null ? message! : "Something Went Wrong",
                    style: Theme.of(context!).textTheme.subtitle2!.copyWith(
                          fontFamily: AllTexts.fontBolt,
                          color: Colors.white,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
          ],
        ),
      ));
  }
}
