import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../managers/api_constant.dart';
import '../../managers/manager.dart';
import '../../managers/manager_exception.dart';
import '../../managers/manager_local_storage.dart';

class CallUsersListApi implements Manager, ExceptionManager{

  Future<void> callUsersListApi() async {
    
  }



  @override
  void appException() {}

  @override
  void fail({required String fail}) {}

  @override
  void success({required String success}) {}
}