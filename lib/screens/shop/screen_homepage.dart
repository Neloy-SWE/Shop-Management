import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/components/custom_button.dart';
import 'package:shop_management/components/custom_loader.dart';
import 'package:shop_management/models/model_shop_info.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/screens/cart/screen_cart.dart';
import 'package:shop_management/screens/shop/screen_update_shop_info.dart';
import 'package:shop_management/screens/users/screen_user_list.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import '../../api/api_call_shop/api_call_shop_info.dart';
import '../../components/custom_dialogue.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_snack_bar.dart';
import '../../components/grid_view_fixed_height.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../managers/option_manager.dart';
import '../../utilities/image_path.dart';
import '../categories/screen_category_list.dart';

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
    setState(() {
      ShopInfoModel shopInfoModel = ShopInfoModel.fromJson(success);

      shopName = shopInfoModel.shopInfoData!.name!;
      address = shopInfoModel.shopInfoData!.address!;
      city = shopInfoModel.shopInfoData!.city!;
      country = shopInfoModel.shopInfoData!.country!;
      profileImage = shopInfoModel.shopInfoData!.profileImage != null
          ? shopInfoModel.shopInfoData!.profileImage!
          : ImagePath.shop;
      location =
          "${shopInfoModel.shopInfoData!.address!}, ${shopInfoModel.shopInfoData!.city!}, ${shopInfoModel.shopInfoData!.country!}.";
    });
  }

  List<OptionManager> options = [
    OptionManager(
      optionIcon: Icons.category,
      optionName: AllTexts.categories,
      navOption: const CategoryList(),
    ),
    OptionManager(
      optionIcon: Icons.people_alt_outlined,
      optionName: AllTexts.users,
      navOption: const UserList(),
    ),
    OptionManager(
      optionIcon: Icons.shopify_rounded,
      optionName: AllTexts.orders,
      navOption: const UserList(),
    ),

    OptionManager(
      optionIcon: Icons.shopping_bag_outlined,
      optionName: AllTexts.cart,
      navOption: const Cart(),
    ),
  ];

  String shopName = "";
  String address = "";
  String city = "";
  String country = "";
  String profileImage = "";
  String location = "";

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
          title: const Text(AllTexts.myShop),
        ),
        endDrawer: const MyDrawer(),
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

            // location
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                Gap.gapW05,
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    location,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
            Gap.gapH15,

            // update shop button
            AllButton.borderedButton(
              context: context,
              btnText: AllTexts.updateShopInfo,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => UpdateShopInfo(
                      shopName: shopName,
                      address: address,
                      city: city,
                      country: country,
                      // image: profileImage,
                    ),
                  ),
                );
              },
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

  // custom container for option element
  Widget _optionContainer(OptionManager optionManager) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => optionManager.navOption,
          ),
        );
      },
      child: Column(
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
      ),
    );
  }
}
