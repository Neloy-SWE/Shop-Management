import 'package:flutter/material.dart';
import 'package:shop_management/screens/categories/screen_category_list.dart';

import '../../api/api_call_category/api_call_add_new_category.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dialogue.dart';
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
import '../authentication/screen_login.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory>
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

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => const CategoryList()));
  }

  final TextEditingController _categoryNameController = TextEditingController();
  final _fromKeyAddNewCategory = GlobalKey<FormState>();
  bool enableButton = false;

  void _addCategory() {
    if (_fromKeyAddNewCategory.currentState!.validate()) {
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
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(AllTexts.addNewCategory),
        ),
        endDrawer: const MyDrawer(),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            // simple icon for add new category
            Gap.gapH30,
            const Icon(
              Icons.add_to_photos_outlined,
              color: AllColors.primaryColor,
              size: 50,
            ),
            Gap.gapH50,

            Form(
              key: _fromKeyAddNewCategory,
              child: Column(
                children: [
                  // text field: store name
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

            // add button
            AllButton.generalButton(
              context: context,
              btnText: AllTexts.addCap,
              onTap: _addCategory,
              enable: enableButton,
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
}
