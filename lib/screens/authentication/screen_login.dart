import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_management/api/auth_api_call/api_call_login.dart';
import 'package:shop_management/components/custom_input.dart';
import 'package:shop_management/components/custom_sign_nav.dart';
import 'package:shop_management/components/custom_snackbar.dart';
import 'package:shop_management/managers/manager.dart';
import 'package:shop_management/screens/authentication/screen_forget_pass.dart';
import 'package:shop_management/screens/authentication/screen_sign_up.dart';
import 'package:shop_management/screens/screen_homepage.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';

import '../../components/custom_button.dart';
import '../../components/custom_dialogue.dart';
import '../../managers/exception_manager.dart';
import '../../models/model_auth/model_login/login_fail.dart';
import '../../models/model_auth/model_login/login_success.dart';
import '../../utilities/all_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements Manager, ExceptionManager {
  @override
  void fail({required String fail}) {
    setState(() {
      enableButton = false;
    });
    LoginFailModel responseFail = LoginFailModel.fromJson(fail);
    String? message =
        responseFail.errors!.email ?? responseFail.errors!.message;
    CustomSnackBar(
            message: message, isSuccess: responseFail.status, context: context)
        .show();
  }

  @override
  void success({required String success}) {
    LoginSuccessModel responseSuccess = LoginSuccessModel.fromJson(success);
    CustomSnackBar(
            message: AllTexts.welcomeBack,
            isSuccess: responseSuccess.status,
            context: context)
        .show();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => const HomePage()));
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

  bool passSecure = true;
  bool enableButton = false;

  final _formKeyLogIn = GlobalKey<FormState>();

  // login method
  void _login() {
    if (_formKeyLogIn.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      setState(() {
        enableButton = true;
      });
      CallLoginApi().callLoginApi(
        login: this,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await AllDialogue.backDialogue(
          context: context,
          onTap: dialogueNav,
          title: AllTexts.exitApp,
          subTitle: AllTexts.exitAppSub,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            // title
            Gap.gapH20,
            Text(
              AllTexts.login,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              AllTexts.toContinue,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Gap.gapH70,

            // login form
            Form(
              key: _formKeyLogIn,
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
                    textInputAction: TextInputAction.done,
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
                  Gap.gapH10,
                ],
              ),
            ),

            // forget password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => const ForgetPassword(),
                    ),
                  );
                },
                child: Text(
                  AllTexts.forgetPass,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Gap.gapH70,

            // submit button
            AllButton.generalButton(
              context: context,
              btnText: AllTexts.loginCap,
              onTap: _login,
              enable: enableButton,
            ),
            Gap.gapH30,

            // sign nav
            CustomSignNav.signNav(
              context: context,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => const SignUp(),
                  ),
                );
              },
              startText: AllTexts.newHere,
              navText: AllTexts.signUp,
            ),
            Gap.gapH30,
          ],
        ),
      ),
    );
  }

  void dialogueNav() {
    SystemNavigator.pop();
  }
}
