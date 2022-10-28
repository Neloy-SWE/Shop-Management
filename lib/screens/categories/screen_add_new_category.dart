import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {

  final TextEditingController _categoryNameController = TextEditingController();
  final _fromKeyAddNewCategory = GlobalKey<FormState>();
  bool enableButton = false;


  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
            onTap: (){},
            enable: enableButton,
          ),
        ],
      ),
    );
  }
}
