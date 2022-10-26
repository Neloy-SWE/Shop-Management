import 'dart:convert';
import 'dart:developer';

import '../../managers/api_constant.dart';
import '../../managers/manager_exception.dart';
import '../../managers/manager.dart';
import 'package:http/http.dart' as http;

class CallRegistrationApi implements Manager, ExceptionManager {
  Future<void> callRegApi({
    required Manager register,
    required ExceptionManager exception,
    required String name,
    required String email,
    required String address,
    required String city,
    required String country,
    required String password,
  }) async {
    try {
      var headers = {ApiConstant.contentType: ApiConstant.acceptValue};
      var request = http.Request(
          'POST', Uri.parse('${ApiConstant.baseUrl}auth/register'));
      request.body = json.encode({
        "name": name,
        "email": email,
        "address": address,
        "city": city,
        "country": country,
        "password": password,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();

      Map data = json.decode(str);
      if (data["status"] == true) {
        register.success(success: str);
      } else {
        register.fail(fail: str);
      }
    } on Exception catch (e) {
      log(e.toString());
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
