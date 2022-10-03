import 'package:flutter/material.dart';
import 'package:shop_management/utilities/app_size.dart';

import '../../utilities/all_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          Gap.gapH20,
          Text(
            AllTexts.login,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            AllTexts.toContinue,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Gap.gapH50


        ],
      ),
    );
  }
}
