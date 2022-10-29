import 'package:flutter/material.dart';
import 'package:shop_management/screens/categories/screen_category_list.dart';

import '../../api/api_call_category/api_call_add_new_category.dart';
import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_auth/model_login/login_fail.dart';
import '../../models/model_auth/model_reset_pass.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class UpdateCategory extends StatefulWidget {
  final String categoryId, categoryName;
  const UpdateCategory({Key? key,
  required this.categoryId,
  required this.categoryName,
  }) : super(key: key);

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory>
    implements Manager, ExceptionManager {
  @override
  void appException() {
    CustomSnackBar(
        message: AllTexts.netError, isSuccess: false, context: context)
        .show();
    setState(() {
      enableButton = false;
    });
  }

  @override
  void fail({required String fail}) {
    LoginFailModel addFail = LoginFailModel.fromJson(fail);
    CustomSnackBar(
        message: addFail.errors!.message,
        isSuccess: addFail.status,
        context: context)
        .show();
    setState(() {
      enableButton = false;
    });
  }

  @override
  void success({required String success}) {
    ResetModel addDone = ResetModel.fromJson(success);
    CustomSnackBar(
        message: addDone.message,
        isSuccess: addDone.status,
        context: context)
        .show();

   /* Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => const CategoryList()));*/
  }

  TextEditingController _categoryNameController = TextEditingController();
  final _fromKeyUpdateCategory = GlobalKey<FormState>();
  bool enableButton = false;

  void _updateCategory() {
    if (_fromKeyUpdateCategory.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });

      CallAddNewCategoryApi().callAddNewCategoryApi(
        add: this,
        exception: this,
        title: _categoryNameController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _categoryNameController = TextEditingController(
        text: _categoryNameController.text.trim().isEmpty
            ? widget.categoryName
            : _categoryNameController.text.trim(),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.addNewUser),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // simple icon for add new category
          Gap.gapH30,
          const Icon(
            Icons.upload_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH50,

          Form(
            key: _fromKeyUpdateCategory,
            child: Column(
              children: [
                // text field: category name
                AllInput.generalInput(
                  context: context,
                  controller: _categoryNameController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.menDot,
                  label: AllTexts.categoryTitle,
                  prefixIcon: Icons.title_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH30,
              ],
            ),
          ),

          // update button
          AllButton.generalButton(
            context: context,
            btnText: AllTexts.updateCap,
            onTap: _updateCategory,
            enable: enableButton,
          ),
        ],
      ),
    );
  }
}
