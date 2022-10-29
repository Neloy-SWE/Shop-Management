import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../managers/api_constant.dart';
import '../../managers/manager_image_upload.dart';
import '../../managers/manager_local_storage.dart';

class CallAddShopProfileImage implements ImageUploadManager {
  Future<void> callAddShopProfileImage({
    required ImageUploadManager upload,
    required String imagePath,
  }) async {
    try {
      String userToken =
          await LocalStorageManager.readData(ApiConstant.userLoginToken);
      var headers = {
        ApiConstant.authorization: "${ApiConstant.bearer} $userToken",
        ApiConstant.contentType: ApiConstant.acceptValue
      };
      var request = http.Request(
        'POST',
        Uri.parse('${ApiConstant.baseUrl}store/add-profile-image'),
      );

      request.body = json.encode({
        "profile_image": imagePath,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var str = await response.stream.bytesToString();
      Map data = json.decode(str);
      if (data["status"] == true) {
        upload.uploadDone(done: str);
      } else {
        upload.uploadFail(fail: str);
      }

    } on Exception catch (e) {
      log(e.toString());
      upload.uploadException();
    }
  }

  @override
  void uploadDone({required String done}) {}

  @override
  void uploadException() {}

  @override
  void uploadFail({required String fail}) {}
}
