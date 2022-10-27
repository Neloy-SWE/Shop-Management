import 'package:flutter/material.dart';
import 'package:shop_management/models/model_auth/model_reset_pass.dart';
import 'package:shop_management/screens/screen_homepage.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import '../api/api_call_shop/api_call_shop_update.dart';
import '../components/custom_button.dart';
import '../components/custom_drawer.dart';
import '../components/custom_input.dart';
import '../components/custom_snackbar.dart';
import '../managers/manager.dart';
import '../managers/manager_exception.dart';

class UpdateShopInfo extends StatefulWidget {
  final String shopName, address, city, country;

  const UpdateShopInfo(
      {Key? key,
      required this.shopName,
      required this.address,
      required this.city,
      required this.country})
      : super(key: key);

  @override
  State<UpdateShopInfo> createState() => _UpdateShopInfoState();
}

class _UpdateShopInfoState extends State<UpdateShopInfo>
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
    ResetModel responseSuccess = ResetModel.fromJson(success);
    CustomSnackBar(
            message: responseSuccess.message,
            isSuccess: responseSuccess.status,
            context: context)
        .show();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => const HomePage()));
  }

  void _update() {
    if (_fromKeyUpdateShop.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });
      CallShopUpdate().callShopUpdate(
        shopUpdate: this,
        exception: this,
        storeName: _storeNameController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
      );
    }
  }

  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  bool enableButton = false;
  final _fromKeyUpdateShop = GlobalKey<FormState>();

  @override
  void dispose() {
    _storeNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _storeNameController = TextEditingController(
        text: _storeNameController.text.trim().isEmpty
            ? widget.shopName
            : _storeNameController.text.trim(),
      );
      _addressController = TextEditingController(
        text: _addressController.text.trim().isEmpty
            ? widget.address
            : _addressController.text.trim(),
      );
      _cityController = TextEditingController(
        text: _cityController.text.trim().isEmpty
            ? widget.city
            : _cityController.text.trim(),
      );
      _countryController = TextEditingController(
        text: _countryController.text.trim().isEmpty
            ? widget.country
            : _countryController.text.trim(),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.updateShopInfo),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // simple icon for update
          Gap.gapH30,
          const Icon(
            Icons.upload_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH50,

          // update form
          Form(
            key: _fromKeyUpdateShop,
            child: Column(
              children: [
                // text field: store name
                AllInput.generalInput(
                  context: context,
                  controller: _storeNameController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.storeNameHint,
                  label: AllTexts.storeName,
                  prefixIcon: Icons.store_mall_directory_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: address
                AllInput.generalInput(
                  context: context,
                  controller: _addressController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.addressHint,
                  label: AllTexts.address,
                  prefixIcon: Icons.location_on_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: city
                AllInput.generalInput(
                  context: context,
                  controller: _cityController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.cityHint,
                  label: AllTexts.city,
                  prefixIcon: Icons.location_city,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: country
                AllInput.generalInput(
                  context: context,
                  controller: _countryController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.countryHint,
                  label: AllTexts.country,
                  prefixIcon: Icons.my_location_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH70,
              ],
            ),
          ),

          // update button
          AllButton.generalButton(
            context: context,
            btnText: AllTexts.updateCap,
            onTap: _update,
            enable: enableButton,
          ),
        ],
      ),
    );
  }
}
