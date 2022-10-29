import 'package:flutter/material.dart';
import 'package:shop_management/screens/products/screen_product_list.dart';

import '../../api/api_call_product/api_call_add_new_product.dart';
import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_auth/model_reset_pass.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class AddNewProduct extends StatefulWidget {
  final String categoryId, categoryName;

  const AddNewProduct(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct>
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
    CustomSnackBar(
            message: AllTexts.wentWrong, isSuccess: false, context: context)
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
      MaterialPageRoute(
        builder: (builder) => ProductList(
          categoryId: widget.categoryId,
          categoryName: widget.categoryName,
        ),
      ),
    );
  }

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final _fromKeyAddNewProduct = GlobalKey<FormState>();
  bool enableButton = false;

  void _addProduct() {
    if (_fromKeyAddNewProduct.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });

      CallAddNewProductApi().callAddNewProductApi(
        add: this,
        exception: this,
        categoryId: widget.categoryId,
        title: _titleController.text.trim(),
        price: _priceController.text.trim(),
        quantity: _quantityController.text.trim(),
        description: _descriptionController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.addNewProduct),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // simple icon for add new product
          Gap.gapH30,
          const Icon(
            Icons.add_shopping_cart_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH50,

          Form(
            key: _fromKeyAddNewProduct,
            child: Column(
              children: [
                // text field: product name
                AllInput.generalInput(
                  context: context,
                  controller: _titleController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.productHint,
                  label: AllTexts.productName,
                  prefixIcon: Icons.desktop_windows_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: price
                AllInput.generalInput(
                  context: context,
                  controller: _priceController,
                  textInputType: const TextInputType.numberWithOptions(),
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.priceHint,
                  label: AllTexts.price,
                  prefixIcon: Icons.monetization_on_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: quantity
                AllInput.generalInput(
                  context: context,
                  controller: _quantityController,
                  textInputType: const TextInputType.numberWithOptions(),
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.quantityHint,
                  label: AllTexts.quantity,
                  prefixIcon: Icons.fitness_center_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                AllInput.longInput(
                  context: context,
                  controller: _descriptionController,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  hint: AllTexts.description,
                  label: AllTexts.description,
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
            onTap: _addProduct,
            enable: enableButton,
          ),
        ],
      ),
    );
  }
}
