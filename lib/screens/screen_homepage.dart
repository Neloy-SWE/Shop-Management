import 'package:flutter/material.dart';
import 'package:shop_management/components/custom_button.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
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
        ),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            // header image
            Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    AllColors.primaryColor.withOpacity(0.7),
                    BlendMode.hardLight,
                  ),
                  image: const AssetImage(
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
                  ),
                ),
                child: Text(
                  AllTexts.yourShopList,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            Gap.gapH15,

            // shop add button
            AllButton.addButton(
              context: context,
              btnText: AllTexts.addNewShop,
              onTap: () {},
            ),

            // shop list
            // GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
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
