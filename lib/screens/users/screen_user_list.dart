import 'package:flutter/material.dart';
import 'package:shop_management/api/api_call_users/api_call_user_list.dart';
import 'package:shop_management/components/custom_drawer.dart';
import 'package:shop_management/screens/users/screen_add_new_user.dart';
import 'package:shop_management/screens/users/screen_user_details.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import 'package:shop_management/utilities/image_path.dart';
import '../../components/custom_button.dart';
import '../../components/custom_divider.dart';
import '../../components/custom_loader.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../models/model_users/model_users_list.dart';
import '../shop/screen_homepage.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList>
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
      UsersListModel usersListModel = UsersListModel.fromJson(success);

      userList = usersListModel.userListData!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    CallUsersListApi().callUsersListApi(
      usersList: this,
      exception: this,
    );
    super.initState();
  }

  List<UserListData> userList = [];

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (builder) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => const AddNewUser(),
                ),
              );
            },
          ),
          Gap.gapH30,

          // user list title
          Text(
            "${AllTexts.usersList} (${userList.length})",
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH10,

          isLoading
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
              : userList.isEmpty
                  ? Column(
                      children: [
                        Gap.gapH50,
                        Image.asset(
                          ImagePath.error,
                          height: 200,
                        ),
                        Text(
                          AllTexts.noDataFound,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    )
                  :

                  // user list
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: MyPadding.padding10,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return _userList(userListData: userList[index]);
                      },
                    ),
        ],
      ),
    );
  }

  Widget _userList({required UserListData userListData}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => UserDetails(
              userId: userListData.id.toString(),
            ),
          ),
        );
      },
      splashColor: AllColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllDivider.generalDivider(),
          Gap.gapH05,
          Text(userListData.name!),
          Text(
            userListData.email!,
            style: Theme.of(context).textTheme.caption,
          ),
          Gap.gapH05,
          AllDivider.generalDivider(),
        ],
      ),
    );
  }
}
