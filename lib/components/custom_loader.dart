import 'package:flutter/material.dart';

class AllLoader{
  static generalLoader({
    required Color loaderColor,
    double loaderSize = 15,
    double loaderWidth = 1.5,
}){
    return SizedBox(
      height: loaderSize,
      width: loaderSize,
      child: CircularProgressIndicator(
        color: loaderColor,
        strokeWidth: loaderWidth,
      ),
    );
  }
}