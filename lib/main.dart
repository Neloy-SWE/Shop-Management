import 'package:flutter/material.dart';
import 'package:shop_management/screens/screen_splash.dart';
import 'package:shop_management/theme/my_theme.dart';
import 'package:shop_management/utilities/all_text.dart';

void main() {
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AllTexts.title,
        theme: AppTheme.myTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
