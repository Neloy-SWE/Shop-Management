import 'package:flutter/material.dart';
import 'package:shop_management/models/model_users/model_required_field.dart';
import 'package:shop_management/screens/users/screen_user_details.dart';
import '../../api/api_call_users/api_call_update_user_details.dart';
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

class UpdateUserInfo extends StatefulWidget {
  final String userId, name, email, address, city, country;

  const UpdateUserInfo({
    Key? key,
    required this.userId,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.country,
  }) : super(key: key);

  @override
  State<UpdateUserInfo> createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo>
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
    UserUpdateRequiredFieldModel requiredField =
        UserUpdateRequiredFieldModel.fromJson(fail);
    CustomSnackBar(
            message: requiredField.errors!.email,
            isSuccess: requiredField.status,
            context: context)
        .show();

    setState(() {
      enableButton = false;
    });
  }

  @override
  void success({required String success}) {
    ResetModel update = ResetModel.fromJson(success);
    CustomSnackBar(
            message: update.message, isSuccess: update.status, context: context)
        .show();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (builder) => UserDetails(
          userId: widget.userId,
        ),
      ),
    );
  }

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

  void _updateUser() {
    if (_fromKeyUpdateUser.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });

      CallUpdateUserApi().callUpdateUserApi(
        update: this,
        exception: this,
        userId: widget.userId,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
      );
    }
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
              onTap: _updateUser,
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
