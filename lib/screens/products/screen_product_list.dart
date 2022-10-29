import 'package:flutter/material.dart';
import 'package:shop_management/screens/products/screen_add_new_product.dart';
import 'package:shop_management/screens/products/screen_product_details.dart';

import '../../api/api_call_product/api_call_product_list.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dialogue.dart';
import '../../components/custom_divider.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_product/model_product_list.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';
import '../../utilities/image_path.dart';
import '../authentication/screen_login.dart';
import '../categories/screen_category_list.dart';
import '../categories/screen_update_category.dart';

class ProductList extends StatefulWidget {
  final String categoryId, categoryName;

  const ProductList({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    implements Manager, ExceptionManager {
  @override
  void appException() {
    CustomSnackBar(
            message: AllTexts.netError, isSuccess: false, context: context)
        .show();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void fail({required String fail}) {
    CustomSnackBar(
            message: AllTexts.wentWrong, isSuccess: false, context: context)
        .show();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void success({required String success}) {
    setState(() {
      ProductListModel productList = ProductListModel.fromJson(success);

      for (int i = 0; i < productList.productListData!.length; i++) {
        if (productList.productListData![i].category!.id == widget.categoryId) {
          productListData.add(productList.productListData![i]);
        }
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    CallProductListApi().callProductListApi(
      productList: this,
      exception: this,
    );
    super.initState();
  }

  bool isLoading = true;

  List<ProductListData> productListData = [];

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
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (builder) => const CategoryList(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(widget.categoryName),
        ),
        endDrawer: const MyDrawer(),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            // simple icon for product list
            Gap.gapH30,
            const Icon(
              Icons.fact_check_outlined,
              color: AllColors.primaryColor,
              size: 50,
            ),
            Gap.gapH20,

            // add new product button
            AllButton.borderedButton(
              context: context,
              btnText: AllTexts.addNewProduct,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => AddNewProduct(
                      categoryId: widget.categoryId,
                      categoryName: widget.categoryName,
                    ),
                  ),
                );
              },
            ),
            Gap.gapH15,

            // update category button
            AllButton.borderedButton(
              context: context,
              btnText: AllTexts.updateCategoryInfo,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => UpdateCategory(
                      categoryId: widget.categoryId,
                      categoryName: widget.categoryName,
                    ),
                  ),
                );
              },
            ),
            Gap.gapH30,

            // product list title
            Text(
              "${AllTexts.categoryList} (${productListData.length})",
              style: Theme.of(context).textTheme.caption,
            ),
            Gap.gapH10,

            isLoading
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
                : productListData.isEmpty
                    ? Column(
                        children: [
                          Gap.gapH50,
                          Image.asset(
                            ImagePath.error,
                            height: 200,
                          ),
                          Text(
                            AllTexts.noDataFound,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      )
                    :

                    // product list
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: MyPadding.padding10,
                        itemCount: productListData.length,
                        itemBuilder: (context, index) {
                          return _productList(
                              productListData: productListData[index]);
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

  Widget _productList({required ProductListData productListData}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => ProductDetails(
              categoryId: productListData.category!.id!,
              productId: productListData.id!,
              categoryName: productListData.category!.title!,
            ),
          ),
        );
      },
      splashColor: AllColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllDivider.generalDivider(),
          Gap.gapH05,
          Text(productListData.title!),
          Text(
            "Price: ${productListData.price} /=",
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH05,
          AllDivider.generalDivider(),
        ],
      ),
    );
  }
}
