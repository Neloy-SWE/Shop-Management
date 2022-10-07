import 'package:flutter/material.dart';
import 'package:shop_management/components/custom_input.dart';
import 'package:shop_management/components/custom_sign_nav.dart';
import 'package:shop_management/screens/authentication/screen_sign_up.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';

import '../../components/custom_button.dart';
import '../../utilities/all_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool passSecure = true;

  final _formKeyLogIn = GlobalKey<FormState>();

  void _login() {
    if (_formKeyLogIn.currentState!.validate()) {
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
    _emailController.dispose();
    _passController.dispose();
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
                  controller: _passController,
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
                      return "password length is less than 6 !!";
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
              onPressed: () {},
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
    );
  }
}
