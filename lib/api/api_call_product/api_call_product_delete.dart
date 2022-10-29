import 'dart:convert';
import 'dart:developer';
import 'package:shop_management/managers/manager_delete.dart';
import '../../managers/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../managers/manager_local_storage.dart';

class CallDeleteProductApi implements DeleteManager {
  Future<void> callDeleteProductApi({
    required DeleteManager delete,
    required String productId,
  }) async {
    try {
      String userToken =
          await LocalStorageManager.readData(ApiConstant.userLoginToken);
      var headers = {
        ApiConstant.authorization: "${ApiConstant.bearer} $userToken"
      };

      var request = http.Request(
        'DELETE',
        Uri.parse('${ApiConstant.baseUrl}product/$productId'),
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);
      if (data["status"] == true) {
        delete.deleteDone(done: str);
      } else {
        delete.deleteFail(fail: str);
      }
    } on Exception catch (e) {
      log(e.toString());
      delete.deleteException();
    }
  }

  @override
  void deleteException() {}

  @override
  void deleteFail({required String fail}) {}

  @override
  void deleteDone({required String done}) {}
}
