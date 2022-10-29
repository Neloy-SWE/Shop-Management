import 'package:flutter/material.dart';
import 'package:shop_management/screens/products/screen_update_product.dart';

import '../../api/api_call_product/api_call_product_details.dart';
import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_product/model_product_details.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class ProductDetails extends StatefulWidget {
  final String categoryId, productId;

  const ProductDetails({
    Key? key,
    required this.categoryId,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
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
      ProductDetailsModel detailsModel = ProductDetailsModel.fromJson(success);
      productName = detailsModel.productDetailsData!.title!;
      price = detailsModel.productDetailsData!.price.toString();
      quantity = detailsModel.productDetailsData!.quantity.toString();
      description = detailsModel.productDetailsData!.description!;
    });
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
    return Scaffold(
        appBar: AppBar(
          //     leading: IconButton(
          //     onPressed: () {
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(
          //       builder: (builder) => const UserList(),
          //     ),
          //   );
          // },
          // icon: const Icon(Icons.arrow_back),
          // ),
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
                        style: Theme.of(context).textTheme.headline1!.copyWith(
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
                    onTap: (){},
                    enable: enableButton,
                    color: AllColors.errorColor,
                  ),
                ],
              ));
  }
}
