import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import 'package:shop_management/utilities/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (builder) => const Login(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.splash,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Gap.gapH50,
            Text(
              AllTexts.welcome,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              AllTexts.toYourShop,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Gap.gapH50,
            const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: AllColors.primaryColor,
                strokeWidth: 1.5,
              ),
            ),
            Gap.gapH20,
            Text(
              AllTexts.copyRight,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
