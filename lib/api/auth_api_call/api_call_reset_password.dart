import 'dart:convert';

import 'package:shop_management/managers/exception_manager.dart';
import 'package:shop_management/managers/manager.dart';
import 'package:http/http.dart' as http;
import '../../managers/api_constant.dart';

class CallResetPassApi implements Manager, ExceptionManager {
  Future<void> callResetPassApi({
    required Manager reset,
    required ExceptionManager exception,
    required String email,
    required String password,
  }) async {
    try {
      var headers = {ApiConstant.contentType: ApiConstant.acceptValue};
      var request =
          http.Request('POST', Uri.parse('${ApiConstant.baseUrl}auth/reset'));
      request.body = json.encode({"email": email, "password": password});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);
      if (data["status"] == true) {
        reset.success(success: str);
      } else {
        reset.fail(fail: str);
      }
    } on Exception catch (e) {
      exception.appException();
    }
  }

  @override
  void appException() {}

  @override
  void fail({required String fail}) {}

  @override
  void success({required String success}) {}
}
