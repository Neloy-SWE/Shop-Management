import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class UpdateUserInfo extends StatefulWidget {
  final String name, email, address, city, country;

  const UpdateUserInfo({
    Key? key,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.country,
  }) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
   TextEditingController _nameController = TextEditingController();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _addressController = TextEditingController();
   TextEditingController _cityController = TextEditingController();
   TextEditingController _countryController = TextEditingController();

  final _fromKeyUpdateUser = GlobalKey<FormState>();
  bool enableButton = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      _nameController = TextEditingController(
        text: _nameController.text.trim().isEmpty
            ? widget.name
            : _nameController.text.trim(),
      );
      _emailController = TextEditingController(
        text: _emailController.text.trim().isEmpty
            ? widget.email
            : _emailController.text.trim(),
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
        title: const Text(AllTexts.updateUserInfo),
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

          Form(
            key: _fromKeyUpdateUser,
            child: Column(
              children: [
                // text field: store name
                AllInput.generalInput(
                  context: context,
                  controller: _nameController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.nameHint,
                  label: AllTexts.name,
                  prefixIcon: Icons.account_box_outlined,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: email
                AllInput.generalInput(
                  context: context,
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hint: AllTexts.emailHint,
                  label: AllTexts.email,
                  prefixIcon: Icons.mark_email_read_outlined,
                  validatorFunction: (value) {
                    String pattern =
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                    RegExp regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter valid email';
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
                Gap.gapH30,
              ],
            ),
          ),

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
