import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

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

          // user list title
          Text(
            "${AllTexts.categoryList} (${categoryListData.length})",
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH10,
        ],
      ),
    );
  }
}
