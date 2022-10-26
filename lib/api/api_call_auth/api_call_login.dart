import 'dart:convert';
import 'dart:developer';
import 'package:shop_management/managers/manager.dart';
import '../../managers/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../managers/manager_exception.dart';
import '../../managers/manager_local_storage.dart';
import '../../models/model_auth/model_login/login_success.dart';

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
      log(e.toString());
     exception.appException();
    }
  }

  @override
  void fail({required String fail}) {}

  @override
  void success({required String success}) {}

  @override
  void appException() {}

//save token at shared preference
  sharedPreference(LoginSuccessModel user) {
    LocalStorageManager.saveData(ApiConstant.userLoginToken, user.token);
  }
}
