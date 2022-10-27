import 'package:flutter/material.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';

import '../components/custom_dialogue.dart';
import '../components/custom_drawer.dart';
import 'authentication/screen_login.dart';

class UpdateShopInfo extends StatefulWidget {
  const UpdateShopInfo({Key? key}) : super(key: key);

  @override
  State<UpdateShopInfo> createState() => _UpdateShopInfoState();
}

class _UpdateShopInfoState extends State<UpdateShopInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.updateShopInfo),
      ),
      endDrawer: const MyDrawer(),
    );
  }

}
