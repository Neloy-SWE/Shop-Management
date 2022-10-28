import 'package:flutter/material.dart';
import 'package:shop_management/api/api_call_users/api_call_add_new_user.dart';
import 'package:shop_management/screens/users/screen_user_list.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../components/custom_snackbar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_auth/model_reset_pass.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({Key? key}) : super(key: key);

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser>
    implements Manager, ExceptionManager {
  @override
  void appException() {
    CustomSnackBar(
            message: AllTexts.netError, isSuccess: false, context: context)
        .show();
  }

  @override
  void fail({required String fail}) {
    ResetModel addFail = ResetModel.fromJson(fail);
    CustomSnackBar(
            message: addFail.message,
            isSuccess: addFail.status,
            context: context)
        .show();
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
        MaterialPageRoute(builder: (builder) => const UserList()));
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _fromKeyAddNewUser = GlobalKey<FormState>();
  bool passSecure = true;
  bool confirmPassSecure = true;
  bool enableButton = false;

  void _addUser() {
    if (_fromKeyAddNewUser.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });

      CallAddNewUserApi().callAddNewUserApi(
        add: this,
        exception: this,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          // simple icon for add new user
          Gap.gapH30,
          const Icon(
            Icons.person_add_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH50,

          Form(
            key: _fromKeyAddNewUser,
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
                Gap.gapH15,

                // text field: password
                AllInput.generalInput(
                  context: context,
                  controller: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.phonelink_lock,
                  suffixWidget: IconButton(
                    onPressed: () {
                      setState(() {
                        passSecure = !passSecure;
                      });
                    },
                    icon: Icon(
                      passSecure ? Icons.visibility_off : Icons.visibility,
                      color: AllColors.primaryColor,
                    ),
                  ),
                  label: AllTexts.password,
                  hint: AllTexts.passHint,
                  secure: passSecure,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    } else if (value.length < 6) {
                      return "Password length is less than 6 !!";
                    }
                    return null;
                  },
                ),
                Gap.gapH15,

                // text field: confirm password
                AllInput.generalInput(
                  context: context,
                  controller: _confirmPasswordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.phonelink_lock,
                  suffixWidget: IconButton(
                    onPressed: () {
                      setState(() {
                        confirmPassSecure = !confirmPassSecure;
                      });
                    },
                    icon: Icon(
                      confirmPassSecure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AllColors.primaryColor,
                    ),
                  ),
                  label: AllTexts.confirmPassword,
                  hint: AllTexts.passHint,
                  secure: confirmPassSecure,
                  validatorFunction: (value) {
                    if (value!.isEmpty) {
                      return "Field is required !!";
                    } else if (value.length < 6) {
                      return "Password length is less than 6 !!";
                    } else if (_passwordController.text.trim() != value) {
                      return "Password is not matched !!";
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
            btnText: AllTexts.addCap,
            onTap: _addUser,
            enable: enableButton,
          ),
        ],
      ),
    );
  }
}
