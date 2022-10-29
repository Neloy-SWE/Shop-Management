import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
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

class _ProductDetailsState extends State<ProductDetails> {
  String productName = "jkl";
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
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (builder) => UpdateUserInfo(
                      //         userId: widget.userId,
                      //         name: name,
                      //         email: email,
                      //         address: address,
                      //         city: city,
                      //         country: country),
                      //   ),
                      // );
                    },
                  ),
                  Gap.gapH15,

                  // add button
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
