import 'package:flutter/material.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import '../components/custom_button.dart';
import '../components/custom_drawer.dart';
import '../components/custom_input.dart';

class UpdateShopInfo extends StatefulWidget {
  const UpdateShopInfo({Key? key}) : super(key: key);

  @override
  State<UpdateShopInfo> createState() => _UpdateShopInfoState();
}

class _UpdateShopInfoState extends State<UpdateShopInfo> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  bool enableButton = false;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.updateShopInfo),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          Gap.gapH30,
          const Icon(
            Icons.upload_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH50,
          // text field: store name
          AllInput.generalInput(
            context: context,
            controller: _storeNameController,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            hint: AllTexts.storeNameHint,
            label: AllTexts.storeName,
            prefixIcon: Icons.store_mall_directory_outlined,
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

          // update button
          AllButton.generalButton(
            context: context,
            btnText: AllTexts.updateCap,
            onTap: (){},
            enable: enableButton,
          ),
        ],
      ),
    );
  }
}
