import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class AllInput {
  static generalInput({
    bool secure = false,
    required BuildContext context,
    IconData? prefixIcon,
    final String? Function(String?)? validatorFunction,
    String hint = "",
    String label = "",
    IconData? suffixIcon,
    Widget? suffixWidget,
    required TextEditingController controller,
    required TextInputType textInputType,
    required TextInputAction textInputAction,
    Function? callbackFunction,
  }) {
    return TextFormField(
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: AllColors.primaryColor),
      validator: validatorFunction,
      obscureText: secure,
      controller: controller,
      keyboardType: textInputType,
      cursorColor: AllColors.primaryColor,
      textInputAction: textInputAction,
      onChanged: (value) {
        if (callbackFunction != null) {
          callbackFunction(value);
        }
      },
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.headline2,
        contentPadding: const EdgeInsets.all(10),
        alignLabelWithHint: true,
        prefixIcon: Icon(
          prefixIcon,
          color: AllColors.primaryColor,
        ),
        suffixIcon: suffixWidget,
        // suffix: suffixWidget,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AllColors.primaryColor),
          borderRadius: BorderRadius.circular(7),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AllColors.errorColor),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.5, color: Colors.black),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black54),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: AllColors.errorColor),
          borderRadius: BorderRadius.circular(7),
        ),

        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black26,
            ),
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: AllColors.primaryColor,
            ),
      ),
    );
  }

  static longInput({
    required BuildContext context,
    final String? Function(String?)? validatorFunction,
    String hint = "",
    String label = "",
    required TextEditingController controller,
    required TextInputType textInputType,
    required TextInputAction textInputAction,
    Function? callbackFunction,
}){
    {
      return TextFormField(
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: AllColors.primaryColor),
        validator: validatorFunction,
        maxLines: 4,
        controller: controller,
        keyboardType: textInputType,
        cursorColor: AllColors.primaryColor,
        textInputAction: textInputAction,
        onChanged: (value) {
          if (callbackFunction != null) {
            callbackFunction(value);
          }
        },
        decoration: InputDecoration(
          errorStyle: Theme.of(context).textTheme.headline2,
          contentPadding: const EdgeInsets.all(10),
          alignLabelWithHint: true,
          // suffix: suffixWidget,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AllColors.primaryColor),
            borderRadius: BorderRadius.circular(7),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AllColors.errorColor),
            borderRadius: BorderRadius.circular(7),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(7),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.black54),
            borderRadius: BorderRadius.circular(7),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AllColors.errorColor),
            borderRadius: BorderRadius.circular(7),
          ),

          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.black26,
          ),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: AllColors.primaryColor,
          ),
        ),
      );
    }
  }
}
