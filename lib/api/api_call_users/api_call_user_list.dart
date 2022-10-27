import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../managers/api_constant.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../managers/manager_local_storage.dart';

class CallUsersListApi implements Manager, ExceptionManager {
  Future<void> callUsersListApi({
    required Manager usersList,
    required ExceptionManager exception,
  }) async {
    try {
      String userToken =
          await LocalStorageManager.readData(ApiConstant.userLoginToken);
      var headers = {
        ApiConstant.authorization: "${ApiConstant.bearer} $userToken"
      };

      var request = http.Request(
        'GET',
        Uri.parse('${ApiConstant.baseUrl}user?page=1&limit=1000'),
      );

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);

      if (data["status"] == true) {
        usersList.success(success: str);
      } else {
        usersList.fail(fail: str);
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