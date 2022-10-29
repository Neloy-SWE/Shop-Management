import 'package:flutter/material.dart';
import 'package:shop_management/api/api_call_product/api_call_product_delete.dart';
import 'package:shop_management/screens/products/screen_product_list.dart';
import 'package:shop_management/screens/products/screen_update_product.dart';

import '../../api/api_call_product/api_call_product_details.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dialogue.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_delete.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_auth/model_reset_pass.dart';
import '../../models/model_product/model_product_details.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';
import '../authentication/screen_login.dart';

class ProductDetails extends StatefulWidget {
  final String categoryId, productId, categoryName;

  const ProductDetails({
    Key? key,
    required this.categoryId,
    required this.productId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    implements Manager, ExceptionManager, DeleteManager {
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
      ProductDetailsModel detailsModel = ProductDetailsModel.fromJson(success);
      productName = detailsModel.productDetailsData!.title!;
      price = detailsModel.productDetailsData!.price.toString();
      quantity = detailsModel.productDetailsData!.quantity.toString();
      description = detailsModel.productDetailsData!.description!;
    });
  }

  @override
  void deleteException() {
    CustomSnackBar(
            message: AllTexts.netError, isSuccess: false, context: context)
        .show();
    setState(() {
      enableButton = false;
    });
  }

  @override
  void deleteFail({required String fail}) {
    CustomSnackBar(
            message: AllTexts.wentWrong, isSuccess: false, context: context)
        .show();
    setState(() {
      enableButton = false;
    });
  }

  @override
  void deleteDone({required String done}) {
    ResetModel deleteDone = ResetModel.fromJson(done);
    CustomSnackBar(
            message: deleteDone.message,
            isSuccess: deleteDone.status,
            context: context)
        .show();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (builder) => ProductList(
          categoryId: widget.categoryId,
          categoryName: widget.categoryName,
        ),
      ),
    );
  }

  @override
  void initState() {
    CallProductDetailsApi().callProductDetailsApi(
      exception: this,
      details: this,
      productId: widget.productId,
    );
    super.initState();
  }

  String productName = "";
  String price = "";
  String quantity = "";
  String description = "";
  bool enableButton = false;

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
                    builder: (builder) => ProductList(
                      categoryId: widget.categoryId,
                      categoryName: widget.categoryName,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(AllTexts.productDetails),
          ),
          endDrawer: const MyDrawer(),
          body: productName.isEmpty
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
              : ListView(
                  padding: MyPadding.appPadding,
                  children: [
                    // details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 25,
                                  ),
                        ),
                        Text(
                          "Price: $price /=",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "Quantity Left: $quantity (KG or pieces)",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          "Description: $description",
                          maxLines: 10,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Gap.gapH30,

                    // update product info
                    AllButton.borderedButton(
                      context: context,
                      btnText: AllTexts.updateUserInfo,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => UpdateProduct(
                              productId: widget.productId,
                              categoryId: widget.categoryId,
                              description: description,
                              price: price,
                              productName: productName,
                              quantity: quantity,
                              categoryName: widget.categoryName,
                            ),
                          ),
                        );
                      },
                    ),
                    Gap.gapH15,

                    // delete button
                    AllButton.generalButton(
                      context: context,
                      btnText: AllTexts.deleteProductCap,
                      onTap: () {
                        AllDialogue.backDialogue(
                          context: context,
                          onTap: _delete,
                          title: AllTexts.deleteExc,
                          subTitle: AllTexts.deleteProduct,
                          color: AllColors.errorColor,
                        );
                      },
                      enable: enableButton,
                      color: AllColors.errorColor,
                    ),
                  ],
                )),
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

  void _delete() {
    CallDeleteProductApi().callDeleteProductApi(
      delete: this,
      productId: widget.productId,
    );
    setState(() {
      enableButton = true;
    });
  }
}
