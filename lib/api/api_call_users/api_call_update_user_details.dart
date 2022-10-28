import 'dart:convert';
import 'dart:developer';

import '../../managers/api_constant.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import 'package:http/http.dart' as http;

import '../../managers/manager_local_storage.dart';

class CallUpdateUserApi implements Manager, ExceptionManager {
  Future<void> callUpdateUserApi({
    required Manager update,
    required ExceptionManager exception,
    required String userId,
    required String name,
    required String email,
    required String address,
    required String city,
    required String country,
  }) async {
    try {
      String userToken =
          await LocalStorageManager.readData(ApiConstant.userLoginToken);
      var headers = {
        ApiConstant.authorization: "${ApiConstant.bearer} $userToken",
        ApiConstant.contentType: ApiConstant.acceptValue
      };

      var request = http.Request(
        'PUT',
        Uri.parse('${ApiConstant.baseUrl}user/$userId'),
      );

      request.body = json.encode({
        "name": name,
        "email": email,
        "address": address,
        "city": city,
        "country": country,
        "profile_image": "",
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);
      if (data["status"] == true) {
        update.success(success: str);
      } else {
        update.fail(fail: str);
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
