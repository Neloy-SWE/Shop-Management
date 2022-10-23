import 'package:flutter/material.dart';
import 'package:shop_management/api/auth_api_call/api_call_reset_password.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';

import '../../components/custom_button.dart';
import '../../components/custom_input.dart';
import '../../components/custom_snackbar.dart';
import '../../managers/exception_manager.dart';
import '../../managers/manager.dart';
import '../../models/model_auth/model_reset_pass.dart';
import '../../utilities/all_text.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    implements Manager, ExceptionManager {
  @override
  void fail({required String fail}) {
    setState(() {
      enableButton = false;
    });
    CustomSnackBar(
            message: AllTexts.resetPassFail, isSuccess: false, context: context)
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
        MaterialPageRoute(builder: (builder) => const Login()));
  }

  @override
  void appException() {
    setState(() {
      enableButton = false;
    });
    CustomSnackBar(
            message: AllTexts.netError, isSuccess: false, context: context)
        .show();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passSecure = true;
  bool confirmPassSecure = true;
  bool enableButton = false;

  final _formKeySignUp = GlobalKey<FormState>();

  void _forgetPass() {
    if (_formKeySignUp.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });
      CallResetPassApi().callResetPassApi(
        reset: this,
        exception: this,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
            AllTexts.resetPassword,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            AllTexts.justAStep,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Gap.gapH70,

          // forget pass form
          Form(
            key: _formKeySignUp,
            child: Column(
              children: [
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
                Gap.gapH70,
              ],
            ),
          ),

          // submit button
          AllButton.generalButton(
            context: context,
            btnText: AllTexts.resetPasswordCap,
            onTap: _forgetPass,
            enable: enableButton,
          ),
          Gap.gapH30,
        ],
      ),
    );
  }
}
