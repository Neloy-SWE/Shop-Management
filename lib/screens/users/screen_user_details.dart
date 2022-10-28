import 'package:flutter/material.dart';
import 'package:shop_management/api/api_call_users/api_call_user_details.dart';
import 'package:shop_management/screens/users/screen_user_list.dart';
import 'package:shop_management/utilities/all_text.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_loader.dart';
import '../../components/custom_snackbar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_users/model_user_details.dart';
import '../../utilities/app_size.dart';
import '../../utilities/colors.dart';

class UserDetails extends StatefulWidget {
  final String userId;

  const UserDetails({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    implements Manager, ExceptionManager {
  @override
  void appException() {
    CustomSnackBar(
            message: AllTexts.netError, isSuccess: false, context: context)
        .show();
  }

  @override
  void fail({required String fail}) {
    CustomSnackBar(
            message: AllTexts.wentWrong, isSuccess: false, context: context)
        .show();
  }

  @override
  void success({required String success}) {
    setState(() {
      UsersDetailsModel detailsModel = UsersDetailsModel.fromJson(success);
      name = detailsModel.userDetailsData!.name!;
      email = detailsModel.userDetailsData!.email!;
      address = detailsModel.userDetailsData!.address!;
      city = detailsModel.userDetailsData!.city!;
      country = detailsModel.userDetailsData!.country!;
      location = "Address: $address, $city, $country";
    });
  }

  String name = "";
  String email = "";
  String address = "";
  String city = "";
  String country = "";
  String location = "";

  @override
  void initState() {
    CallUserDetailsApi().callUserDetailsApi(
      exception: this,
      details: this,
      userId: widget.userId,
    );
    super.initState();
  }

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
      body: name.isEmpty
          ? Column(
              children: [
                Gap.gapH50,
                Align(
                  alignment: Alignment.center,
                  child: AllLoader.generalLoader(
                    loaderColor: AllColors.primaryColor,
                    loaderWidth: 2,
                    loaderSize: 30,
                  ),
                ),
              ],
            )
          : ListView(
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
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 30,
                      ),
                ),

                // user mail
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Gap.gapH15,

                Text(
                  location,
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
