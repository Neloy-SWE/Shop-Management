import 'package:flutter/material.dart';

import '../utilities/all_text.dart';
import '../utilities/app_size.dart';
import '../utilities/colors.dart';

class AllDialogue {
  static backDialogue({
    required BuildContext context,
    required Function() onTap,
    required String title,
    required String subTitle,
    Color color = AllColors.primaryColor,
  }) {
    return showDialog(
      context: context,
      builder: (builder) {
        return SimpleDialog(
          contentPadding: MyPadding.appPadding,
          title: Text(title, textAlign: TextAlign.center),
          titleTextStyle: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontFamily: AllTexts.fontBolt),
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 85),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            Gap.gapH50,

            // yes no button
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MaterialButton(
                    height: 45,
                    elevation: 0,
                    onPressed: onTap,
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7,
                        ),
                      ),
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      AllTexts.yesCap,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Gap.gapW10,
                Expanded(
                  child: MaterialButton(
                    height: 45,
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: color,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7,
                        ),
                      ),
                    ),
                    child: Text(
                      AllTexts.noCap,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
