import 'package:flutter/material.dart';
import 'package:shop_management/screens/categories/screen_add_new_category.dart';

import '../../api/api_call_category/api_call_category_list.dart';
import '../../components/custom_button.dart';
import '../../components/custom_divider.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_category/model_category_list.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';
import '../../utilities/image_path.dart';
import '../products/screen_product_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
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
      CategoryListModel categoryList = CategoryListModel.fromJson(success);

      categoryListData = categoryList.categoryListData!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    CallCategoryListApi().callCategoryListApi(
      categoryList: this,
      exception: this,
    );
    super.initState();
  }

  bool isLoading = true;

  List<CategoryListData> categoryListData = [];
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

          // add new category button
          AllButton.borderedButton(
            context: context,
            btnText: AllTexts.addNewCategory,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => const AddNewCategory(),
                ),
              );
            },
          ),
          Gap.gapH30,

          // category list title
          Text(
            "${AllTexts.categoryList} (${categoryListData.length})",
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
              : categoryListData.isEmpty
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

          // category list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: MyPadding.padding10,
            itemCount: categoryListData.length,
            itemBuilder: (context, index) {
              return _categoryList(categoryListData: categoryListData[index]);
            },
          ),
        ],
      ),
    );
  }
  Widget _categoryList({required CategoryListData categoryListData}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => ProductList(
              categoryId: categoryListData.id.toString(),
              categoryName: categoryListData.title!,
            ),
          ),
        );
      },
      splashColor: AllColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllDivider.generalDivider(),
          Gap.gapH10,
          Text(categoryListData.title!),
          Gap.gapH10,
          AllDivider.generalDivider(),
        ],
      ),
    );
  }
}
