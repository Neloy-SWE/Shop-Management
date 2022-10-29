import 'package:flutter/material.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/colors.dart';

import '../../components/custom_drawer.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.orders),
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
