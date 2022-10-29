import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_divider.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../models/model_product/model_product_list.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';
import '../../utilities/image_path.dart';

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

class _ProductListState extends State<ProductList> {

  bool isLoading = true;

  List<ProductListData> productListData = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // simple icon for users list
          Gap.gapH30,
          const Icon(
            Icons.fact_check_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH20,

          // add new category button
          AllButton.borderedButton(
            context: context,
            btnText: AllTexts.addNewCategory,
            onTap: () {
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => const AddNewCategory(),
                ),
              );*/
            },
          ),
          Gap.gapH30,

          // product list title
          Text(
            "${AllTexts.categoryList} (${productListData.length})",
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH10,

          // isLoading
          //     ? Column(
          //   children: [
          //     Gap.gapH50,
          //     Align(
          //       alignment: Alignment.center,
          //       child: AllLoader.generalLoader(
          //         loaderColor: AllColors.primaryColor,
          //         loaderWidth: 2,
          //         loaderSize: 30,
          //       ),
          //     ),
          //   ],
          // )
          //     : productListData.isEmpty
          //     ? Column(
          //   children: [
          //     Gap.gapH50,
          //     Image.asset(
          //       ImagePath.error,
          //       height: 200,
          //     ),
          //     Text(
          //       AllTexts.noDataFound,
          //       style: Theme.of(context).textTheme.headline2,
          //     ),
          //   ],
          // )
          //     :

          // product list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: MyPadding.padding10,
            itemCount: /*productListData.length*/ 5,
            itemBuilder: (context, index) {
              return _productList();
            },
          ),
        ],
      ),
    );
  }

  Widget _productList() {
    return InkWell(
      onTap: () {
/*        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => ProductList(
              categoryId: categoryListData.id.toString(),
              categoryName: categoryListData.title!,
            ),
          ),
        );*/
      },
      splashColor: AllColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllDivider.generalDivider(),
          Gap.gapH05,
          Text("Product"),
          Text(
            "Price: ",
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH05,
          AllDivider.generalDivider(),
        ],
      ),
    );
  }
}
