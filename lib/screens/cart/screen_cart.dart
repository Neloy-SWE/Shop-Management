import 'package:flutter/material.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/colors.dart';

import '../../components/custom_drawer.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.cart),
      ),
      endDrawer: const MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.engineering_outlined,
              color: AllColors.primaryColor,
              size: 100,
            ),
            Text(
              AllTexts.underConstructions,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
