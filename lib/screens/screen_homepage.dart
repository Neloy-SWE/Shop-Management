import 'package:flutter/material.dart';
import 'package:shop_management/components/custom_button.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import '../components/custom_dialogue.dart';
import '../components/custom_snackbar.dart';
import '../components/grid_view_fixed_height.dart';
import '../managers/exception_manager.dart';
import '../managers/manager.dart';
import '../managers/option_manager.dart';
import '../models/model_shop_info.dart';
import '../utilities/image_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements Manager, ExceptionManager{

  @override
  void appException() {
    CustomSnackBar(
        message: AllTexts.netError, isSuccess: false, context: context)
        .show();
  }

  @override
  void fail({required String fail}) {
    CustomSnackBar(
        message: AllTexts.wentWrong, isSuccess: false, context: context)
        .show();
  }

  @override
  void success({required String success}) {
    ShopInfoModel shopInfoModel = ShopInfoModel.fromJson(success);
  }

  List<OptionManager> options = [
    OptionManager(
        optionIcon: Icons.category, optionName: AllTexts.categories),
    OptionManager(
        optionIcon: Icons.people_alt_outlined, optionName: AllTexts.users),
    OptionManager(
        optionIcon: Icons.shopify_rounded, optionName: AllTexts.orders),
  ];

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
            // shop view
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
                  "Shop Name",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            Gap.gapH15,

            // update shop button
            AllButton.borderedButton(
              context: context,
              btnText: AllTexts.updateShopInfo,
              onTap: () {},
            ),
            Gap.gapH30,

            // option list
            GridView.builder(
              padding: MyPadding.appPadding,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const GridViewFixedHeight(
                crossAxisCount: 2,
                // childAspectRatio: 0.60,
                height: 170,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                return _optionContainer(options[index]);
              },
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

  Widget _optionContainer(OptionManager optionManager) {
    return Column(
      children: [
        Container(
          height: 110,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AllColors.optionBackColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                20,
              ),
            ),
          ),
          child: Icon(
            optionManager.optionIcon,
            color: AllColors.primaryColor,
            size: 90,
          ),
        ),
        Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AllColors.optionBackColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                20,
              ),
            ),
          ),
          child: Text(
            optionManager.optionName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
