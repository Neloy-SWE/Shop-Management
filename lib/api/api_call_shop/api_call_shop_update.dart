import 'dart:convert';
import 'dart:developer';
import 'package:shop_management/managers/manager.dart';
import 'package:shop_management/managers/manager_exception.dart';
import 'package:http/http.dart' as http;
import '../../managers/api_constant.dart';
import '../../managers/manager_local_storage.dart';

class CallShopUpdate implements Manager, ExceptionManager {
  Future<void> callShopUpdate({
    required Manager shopUpdate,
    required ExceptionManager exception,
    required String storeName,
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
        Uri.parse('${ApiConstant.baseUrl}/store'),
      );

      request.body = json.encode({
        "name": storeName,
        "address": address,
        "city": city,
        "country": country,
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);
      if (data["status"] == true) {
        shopUpdate.success(success: str);
      } else {
        shopUpdate.fail(fail: str);
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
