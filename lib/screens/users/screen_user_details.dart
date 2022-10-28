import 'package:flutter/material.dart';
import 'package:shop_management/screens/users/screen_user_list.dart';
import 'package:shop_management/utilities/all_text.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class UserDetails extends StatefulWidget {
  final String userId;

  const UserDetails({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {


  String shopName = "";
  String address = "";
  String city = "";
  String country = "";
  String profileImage = "";
  String location = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (builder) => const UserList(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(AllTexts.userDetails),
      ),
      endDrawer: const MyDrawer(),
      body: ListView(
        padding: MyPadding.appPadding,
        children: [
          // simple icon for user profile
          const Icon(
            Icons.account_circle_outlined,
            color: AllColors.primaryColor,
            size: 150,
          ),

          // user name
          Text(
            "Name",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 30,
                ),
          ),

          // user mail
          Text(
            "email",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Gap.gapH15,

          Text(
            "Address: alsdjfla;sdjfl;kajsdflkjasd",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH30,
          // update user info
          AllButton.borderedButton(
            context: context,
            btnText: AllTexts.updateUserInfo,
            onTap: () {},
          ),
          Gap.gapH30,
        ],
      ),
    );
  }
}
