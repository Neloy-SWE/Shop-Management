// import 'dart:developer';
// import 'dart:io';
// import 'package:shop_management/utilities/image_path.dart';
// import '../../api/api_call_shop/api_call_add_shop_profile_image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shop_management/components/custom_divider.dart';
// import '../../managers/manager_image_upload.dart';

import 'package:flutter/material.dart';
import 'package:shop_management/models/model_auth/model_reset_pass.dart';
import 'package:shop_management/screens/authentication/screen_login.dart';
import 'package:shop_management/screens/shop/screen_homepage.dart';
import 'package:shop_management/utilities/all_text.dart';
import 'package:shop_management/utilities/app_size.dart';
import 'package:shop_management/utilities/colors.dart';
import '../../api/api_call_shop/api_call_shop_update.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dialogue.dart';
import '../../components/custom_drawer.dart';
import '../../components/custom_input.dart';
import '../../components/custom_snack_bar.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';

class UpdateShopInfo extends StatefulWidget {
  final String shopName, address, city, country /*, image*/;

  const UpdateShopInfo({
    Key? key,
    required this.shopName,
    required this.address,
    required this.city,
    required this.country,
    //required this.image,
  }) : super(key: key);

  @override
  State<UpdateShopInfo> createState() => _UpdateShopInfoState();
}

class _UpdateShopInfoState extends State<UpdateShopInfo>
    implements Manager, ExceptionManager /*, ImageUploadManager*/ {
  @override
  void appException() {
    CustomSnackBar(
            message: AllTexts.netError, isSuccess: false, context: context)
        .show();
    setState(() {
      enableButton = false;
    });
  }

  @override
  void fail({required String fail}) {
    CustomSnackBar(
            message: AllTexts.wentWrong, isSuccess: false, context: context)
        .show();

    setState(() {
      enableButton = false;
    });
  }

  @override
  void success({required String success}) {
    ResetModel responseSuccess = ResetModel.fromJson(success);
    CustomSnackBar(
            message: responseSuccess.message,
            isSuccess: responseSuccess.status,
            context: context)
        .show();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (builder) => const HomePage()));
  }

  // @override
  // void uploadDone({required String done}) {}
  //
  // @override
  // void uploadException() {}
  //
  // @override
  // void uploadFail({required String fail}) {}

  void _update() {
    if (_fromKeyUpdateShop.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      // if (profileImage.isEmpty || profileImage == ImagePath.shop) {
      //   setState(() {
      //     showImageUpload = true;
      //   });
      // }
      // else{
      setState(() {
        enableButton = true;
        //showImageUpload = false;
      });
      CallShopUpdate().callShopUpdate(
        shopUpdate: this,
        exception: this,
        storeName: _storeNameController.text.trim(),
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        country: _countryController.text.trim(),
      );
      // CallAddShopProfileImage().callAddShopProfileImage(
      //   upload: this,
      //   imagePath: profileImage,
      // );
      // }
    }
  }

  TextEditingController _storeNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  // String profileImage = "";
  //
  // File? profileImageFile;
  //
  // Future _picImageGallery() async {
  //   try {
  //     final pickedImage = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 50,
  //     );
  //     if (pickedImage == null) return;
  //     final imageFile = File(pickedImage.path);
  //     setState(() {
  //       profileImageFile = imageFile;
  //       profileImage = pickedImage.path;
  //       Navigator.pop(context);
  //     });
  //   } on PlatformException catch (e) {
  //     log(e.toString());
  //     CustomSnackBar(
  //             message: AllTexts.imageSelectFail,
  //             isSuccess: false,
  //             context: context)
  //         .show();
  //   }
  // }
  //
  // Future _picImageCamera() async {
  //   try {
  //     final pickedImage = await ImagePicker().pickImage(
  //       source: ImageSource.camera,
  //       imageQuality: 50,
  //     );
  //     if (pickedImage == null) return;
  //     final imageFile = File(pickedImage.path);
  //     setState(() {
  //       profileImageFile = imageFile;
  //       profileImage = pickedImage.path;
  //       Navigator.pop(context);
  //     });
  //   } on PlatformException catch (e) {
  //     log(e.toString());
  //     CustomSnackBar(
  //             message: AllTexts.imageSelectFail,
  //             isSuccess: false,
  //             context: context)
  //         .show();
  //   }
  // }

  bool enableButton = false;

  //bool showImageUpload = false;
  final _fromKeyUpdateShop = GlobalKey<FormState>();

  @override
  void dispose() {
    _storeNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   profileImage = widget.image;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _storeNameController = TextEditingController(
        text: _storeNameController.text.trim().isEmpty
            ? widget.shopName
            : _storeNameController.text.trim(),
      );
      _addressController = TextEditingController(
        text: _addressController.text.trim().isEmpty
            ? widget.address
            : _addressController.text.trim(),
      );
      _cityController = TextEditingController(
        text: _cityController.text.trim().isEmpty
            ? widget.city
            : _cityController.text.trim(),
      );
      _countryController = TextEditingController(
        text: _countryController.text.trim().isEmpty
            ? widget.country
            : _countryController.text.trim(),
      );
    });
    return WillPopScope(
      onWillPop: () async {
        return await AllDialogue.backDialogue(
          context: context,
          onTap: dialogueNav,
          title: AllTexts.signOut,
          subTitle: AllTexts.signOutSub,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(AllTexts.updateShopInfo),
        ),
        endDrawer: const MyDrawer(isHome: false),
        body: ListView(
          padding: MyPadding.appPadding,
          children: [
            // simple icon for update
            Gap.gapH30,
            const Icon(
              Icons.upload_outlined,
              color: AllColors.primaryColor,
              size: 50,
            ),
            Gap.gapH50,

            // update form
            Form(
              key: _fromKeyUpdateShop,
              child: Column(
                children: [
                  // text field: store name
                  AllInput.generalInput(
                    context: context,
                    controller: _storeNameController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hint: AllTexts.storeNameHint,
                    label: AllTexts.storeName,
                    prefixIcon: Icons.store_mall_directory_outlined,
                    validatorFunction: (value) {
                      if (value!.isEmpty) {
                        return "Field is required !!";
                      }
                      return null;
                    },
                  ),
                  Gap.gapH15,

                  // text field: address
                  AllInput.generalInput(
                    context: context,
                    controller: _addressController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hint: AllTexts.addressHint,
                    label: AllTexts.address,
                    prefixIcon: Icons.location_on_outlined,
                    validatorFunction: (value) {
                      if (value!.isEmpty) {
                        return "Field is required !!";
                      }
                      return null;
                    },
                  ),
                  Gap.gapH15,

                  // text field: city
                  AllInput.generalInput(
                    context: context,
                    controller: _cityController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hint: AllTexts.cityHint,
                    label: AllTexts.city,
                    prefixIcon: Icons.location_city,
                    validatorFunction: (value) {
                      if (value!.isEmpty) {
                        return "Field is required !!";
                      }
                      return null;
                    },
                  ),
                  Gap.gapH15,

                  // text field: country
                  AllInput.generalInput(
                    context: context,
                    controller: _countryController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hint: AllTexts.countryHint,
                    label: AllTexts.country,
                    prefixIcon: Icons.my_location_outlined,
                    validatorFunction: (value) {
                      if (value!.isEmpty) {
                        return "Field is required !!";
                      }
                      return null;
                    },
                  ),
                  Gap.gapH30,
                ],
              ),
            ),

            // image upload
/*          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileImageFile != null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            image: DecorationImage(
                              image: FileImage(profileImageFile!),
                              fit: BoxFit.fill,
                            )),
                      )
                    : profileImage == ImagePath.shop
                        ? const SizedBox()
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(profileImage),
                                  fit: BoxFit.fill,
                                )),
                          ),
                profileImageFile != null || profileImage != ImagePath.shop
                    ? Gap.gapW10
                    : const SizedBox(),
                // upload button
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (builder) => SizedBox(
                        height: 150,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _picImageGallery();
                                },
                                child: Text(
                                  AllTexts.gallery,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              AllDivider.generalDivider(),
                              TextButton(
                                onPressed: () {
                                  _picImageCamera();
                                },
                                child: Text(
                                  AllTexts.camera,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.file_upload_outlined,
                      size: 50,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
            showImageUpload? Gap.gapH10 : const SizedBox(),
            showImageUpload? Text(
              AllTexts.pleaseSelectImage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2,
            ) : const SizedBox(),
            Gap.gapH30,*/

            // update button
            AllButton.generalButton(
              context: context,
              btnText: AllTexts.updateCap,
              onTap: _update,
              enable: enableButton,
            ),
          ],
        ),
      ),
    );
  }

  void dialogueNav() {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (builder) => const Login(),
      ),
    );
  }
}
