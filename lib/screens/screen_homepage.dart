import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/components/custom_button.dart';
import 'package:shop_management/components/custom_loader.dart';
import 'package:shop_management/models/model_shop_info.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import '../api/api_call_with_provider/api_call_shop_info.dart';
import '../components/custom_dialogue.dart';
import '../components/custom_snackbar.dart';
import '../components/grid_view_fixed_height.dart';
import '../managers/manager.dart';
import '../managers/manager_exception.dart';
import '../managers/option_manager.dart';
import '../utilities/image_path.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    implements Manager, ExceptionManager {
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
    print(success);
    setState(() {
      ShopInfoModel shopInfoModel = ShopInfoModel.fromJson(success);

      shopName = shopInfoModel.shopInfoData!.name!;
      profileImage = shopInfoModel.shopInfoData!.profileImage != null
          ? shopInfoModel.shopInfoData!.profileImage!
          : ImagePath.shop;
    });
  }

  List<OptionManager> options = [
    OptionManager(optionIcon: Icons.category, optionName: AllTexts.categories),
    OptionManager(
        optionIcon: Icons.people_alt_outlined, optionName: AllTexts.users),
    OptionManager(
        optionIcon: Icons.shopify_rounded, optionName: AllTexts.orders),
  ];

  String shopName = "";
  String profileImage = "";

  @override
  void initState() {
    CallShopInfoApi().callShopInfoApi(
      shopInfo: this,
      exception: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hello shop name: $shopName $profileImage");

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
            profileImage.isEmpty
                ? Column(
                  children: [
                    Gap.gapH50,
                    Align(
                        alignment: Alignment.center,
                        child: AllLoader.generalLoader(
                          loaderColor: AllColors.primaryColor,
                          loaderWidth: 2,
                          loaderSize: 30,
                        ),
                      ),
                  ],
                )
                : Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          profileImage,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      height: 50,
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
                        shopName,
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
