import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_divider.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';
import '../../utilities/image_path.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool isLoading = true;

  List categoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.categoryList),
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

          // update shop button
          AllButton.borderedButton(
            context: context,
            btnText: AllTexts.addNewCategory,
            onTap: () {},
          ),
          Gap.gapH30,

          // user list title
          Text(
            "${AllTexts.categoryList} (${categoryList.length})",
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
              : categoryList.isEmpty
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

          // user list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: MyPadding.padding10,
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return _categoryList();
            },
          ),
        ],
      ),
    );
  }
  Widget _categoryList() {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (builder) => UserDetails(
        //       userId: userListData.id.toString(),
        //     ),
        //   ),
        // );
      },
      splashColor: AllColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllDivider.generalDivider(),
          Gap.gapH05,
          Text("Category Name"),
          Gap.gapH05,
          AllDivider.generalDivider(),
        ],
      ),
    );
  }
}
