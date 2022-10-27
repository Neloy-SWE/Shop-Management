import 'package:flutter/material.dart';
import 'package:shop_management/components/custom_drawer.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';

import '../../components/custom_button.dart';
import '../../components/custom_divider.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AllTexts.usersList),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // simple icon for users list
          Gap.gapH30,
          const Icon(
            Icons.fact_check_outlined,
            color: AllColors.primaryColor,
            size: 50,
          ),
          Gap.gapH20,

          // update shop button
          AllButton.borderedButton(
            context: context,
            btnText: AllTexts.addNewUser,
            onTap: () {},
          ),
          Gap.gapH30,

          // user list title
          Text(
            "user list",
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH10,

          // user list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: MyPadding.padding10,
            itemCount: 10,
            itemBuilder: (context, index) {
              return _userList();
            },
          ),
        ],
      ),
    );
  }

  Widget _userList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AllDivider.generalDivider(),
        Gap.gapH05,
        Text("Helo"),
        Text(
          "Helo",
          style: Theme.of(context).textTheme.caption,
        ),
        Gap.gapH05,
        AllDivider.generalDivider(),
      ],
    );
  }
}
