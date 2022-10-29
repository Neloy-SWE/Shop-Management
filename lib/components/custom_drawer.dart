import 'package:flutter/material.dart';
import 'package:shop_management/screens/shop/screen_homepage.dart';

import '../screens/authentication/screen_login.dart';
import '../utilities/all_text.dart';
import '../utilities/app_size.dart';
import '../utilities/colors.dart';
import 'custom_dialogue.dart';
import 'custom_divider.dart';

class MyDrawer extends StatefulWidget {
  final bool isHome;

  const MyDrawer({Key? key, this.isHome = true}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: MyPadding.padding10,
        children: [
          Gap.gapH70,
          AllDivider.generalDivider(),
          InkWell(
            onTap: () {
              AllDialogue.backDialogue(
                context: context,
                onTap: dialogueNav,
                title: AllTexts.signOut,
                subTitle: AllTexts.signOutSub,
              );
            },
            splashColor: AllColors.primaryColor,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AllTexts.signOut,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 22,
                        ),
                  ),
                  Gap.gapW10,
                  const Icon(Icons.logout)
                ],
              ),
            ),
          ),
          AllDivider.generalDivider(),
          widget.isHome
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (builder) => const HomePage(),
                      ),
                    );
                  },
                  splashColor: AllColors.primaryColor,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AllTexts.returnHome,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 22,
                                  ),
                        ),
                        Gap.gapW10,
                        const Icon(Icons.home_filled)
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          widget.isHome ? AllDivider.generalDivider() : const SizedBox(),
        ],
      ),
    );
  }

  void dialogueNav() {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (builder) => const Login(),
      ),
    );
  }
}
