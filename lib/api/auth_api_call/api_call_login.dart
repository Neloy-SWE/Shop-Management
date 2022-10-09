import 'dart:convert';
import 'dart:io';
import 'package:shop_management/managers/manager.dart';
import 'package:shop_management/models/model_login/login_success.dart';
import '../../managers/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../managers/exception_manager.dart';
import '../../managers/local_storage_manager.dart';

class CallLoginApi implements Manager, ExceptionManager {
  Future<void> callLoginApi({
    required Manager login,
    required ExceptionManager exception,
    required String email,
    required String password,
  }) async {
    try {
      var headers = {ApiConstant.contentType: ApiConstant.acceptValue};
      var request =
          http.Request('POST', Uri.parse('${ApiConstant.baseUrl}auth/login'));
      request.body = json.encode({
        "email": email,
        "password": password,
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();

      Map data = json.decode(str);
      if (data["status"] == true) {
        sharedPreference(LoginSuccessModel.fromJson(str));
        login.success(success: str);
      } else {
        login.fail(fail: str);
      }
    } on Exception catch (e) {
     exception.appException();
    }
  }

  @override
  void fail({required String fail}) {}

  @override
  void success({required String success}) {}

  @override
  void appException() {}

//save data at shared preference
  sharedPreference(LoginSuccessModel user) {
    LocalStorageManager.saveData(ApiConstant.userLoginToken, user.token);
  }
}
