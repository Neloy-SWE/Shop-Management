import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../managers/api_constant.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../managers/manager_local_storage.dart';

class CallProductDetailsApi implements Manager, ExceptionManager {

  Future<void> callProductDetailsApi(
      {
        required Manager details,
        required ExceptionManager exception,
        required String productId,
      }
      ) async{
    try{
      String userToken =
      await LocalStorageManager.readData(ApiConstant.userLoginToken);
      var headers = {
        ApiConstant.authorization: "${ApiConstant.bearer} $userToken"
      };
      var request = http.Request(
        'GET',
        Uri.parse('${ApiConstant.baseUrl}product/$productId'),
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();

      Map data = json.decode(str);
      if (data["status"] == true) {
        details.success(success: str);
      } else {
        details.fail(fail: str);
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
