import 'package:flutter/material.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import '../components/custom_dialogue.dart';
import '../utilities/image_path.dart';

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 10,
        ),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImagePath.shop,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        50,
                      ),
                    ),),
                child: Text(AllTexts.yourShopList, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2,),
              ),
            ),
          ],
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
