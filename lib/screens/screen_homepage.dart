import 'package:flutter/material.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/utilities/all_text.dart';
import '../components/custom_dialogue.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await AllDialogue.backDialogue(
          context: context,
          onTap: dialogueNav,
          title: AllTexts.signOut,
          subTitle: AllTexts.signOutSub,
        );
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Hello this is home page"),
        ),
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
