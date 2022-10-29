import 'dart:convert';
import 'dart:developer';

import '../../managers/api_constant.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import 'package:http/http.dart' as http;

import '../../managers/manager_local_storage.dart';

class CallUpdateCategoryApi implements Manager, ExceptionManager {
  Future<void> callUpdateCategoryApi({
    required Manager add,
    required ExceptionManager exception,
    required String categoryId,
    required String title,
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
        Uri.parse('${ApiConstant.baseUrl}category/$categoryId'),
      );

      request.body = json.encode({
        "title": title,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);
      if (data["status"] == true) {
        add.success(success: str);
      } else {
        add.fail(fail: str);
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
