import 'package:flutter/material.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';

import '../../components/custom_button.dart';
import '../../components/custom_input.dart';
import '../../components/custom_sign_nav.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passSecure = true;
  bool confirmPassSecure = true;

  final _fromKeySignUp = GlobalKey<FormState>();

  void _signUp() {
    if (_fromKeySignUp.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      // _logInApiCall(
      //   email: _emailController.text.trim(),
      //   password: _passController.text.trim(),
      // );
    }
  }

  @override
  void dispose() {
    _storeNameController.dispose();
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
      appBar: AppBar(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // title
          Gap.gapH20,
          Text(
            AllTexts.createAccount,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            AllTexts.toExplore,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Gap.gapH70,

          // sign up form
          Form(
            key: _fromKeySignUp,
            child: Column(children: [
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
                  String pattern = r"[^a-z^A-Z^0-9]+";
                  RegExp regExp = RegExp(pattern);
                  if (value!.isEmpty) {
                    return "Field is required !!";
                  } else if (!regExp.hasMatch(value)) {
                    return null;
                  } else {
                    return "Avoid Special characters";
                  }
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
                    confirmPassSecure ? Icons.visibility_off : Icons.visibility,
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
              Gap.gapH70,
            ]),
          ),

          // submit button
          AllButton.generalButton(
            context: context,
            btnText: AllTexts.signUpCap,
            onTap: _signUp,
          ),
          Gap.gapH30,

          // sign nav
          CustomSignNav.signNav(
            context: context,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (builder) => const Login(),
                ),
              );
            },
            startText: AllTexts.alreadyHaveAcc,
            navText: AllTexts.login,
          ),
          Gap.gapH30,
        ],
      ),
    );
  }
}
