import 'package:flutter/material.dart';
import 'package:shop_management/screens/products/screen_product_details.dart';
import '../../api/api_call_product/api_call_product_update.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dialogue.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_auth/model_reset_pass.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';
import '../authentication/screen_login.dart';

class UpdateProduct extends StatefulWidget {
  final String categoryId,
      productName,
      price,
      quantity,
      description,
      productId,
      categoryName;

  const UpdateProduct({
    Key? key,
    required this.categoryId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.description,
    required this.productId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct>
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
        builder: (builder) => ProductDetails(
          categoryId: widget.categoryId,
          productId: widget.productId,
          categoryName: widget.categoryName,
        ),
      ),
    );
  }

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  final _fromKeyUpdateProduct = GlobalKey<FormState>();
  bool enableButton = false;

  void _updateProduct() {
    if (_fromKeyUpdateProduct.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });

      CallUpdateProductApi().callUpdateProductApi(
        add: this,
        exception: this,
        categoryId: widget.categoryId,
        title: _titleController.text.trim(),
        price: _priceController.text.trim(),
        quantity: _quantityController.text.trim(),
        description: _descriptionController.text.trim(),
        productId: widget.productId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _titleController = TextEditingController(
        text: _titleController.text.trim().isEmpty
            ? widget.productName
            : _titleController.text.trim(),
      );
      _priceController = TextEditingController(
        text: _priceController.text.trim().isEmpty
            ? widget.price
            : _priceController.text.trim(),
      );
      _quantityController = TextEditingController(
        text: _quantityController.text.trim().isEmpty
            ? widget.quantity
            : _quantityController.text.trim(),
      );
      _descriptionController = TextEditingController(
        text: _descriptionController.text.trim().isEmpty
            ? widget.description
            : _descriptionController.text.trim(),
      );
    });
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
          title: const Text(AllTexts.updateProductInfo),
        ),
        endDrawer: const MyDrawer(),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            // simple icon for add new product
            Gap.gapH30,
            const Icon(
              Icons.upload_outlined,
              color: AllColors.primaryColor,
              size: 50,
            ),
            Gap.gapH50,

            Form(
              key: _fromKeyUpdateProduct,
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

            // update button
            AllButton.generalButton(
              context: context,
              btnText: AllTexts.updateCap,
              onTap: _updateProduct,
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
