import 'package:flutter/material.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              "assets/images/splash.png",
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Gap.gapH50,
            Text(
              "Welcome",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "To Your Shop",
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
            Text(AllTexts.copyRight, style: Theme.of(context).textTheme.subtitle2,)
          ],
        ),
      ),
    );
  }
}
