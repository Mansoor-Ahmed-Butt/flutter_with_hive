import 'dart:convert';

import 'package:flutter_with_hive/core/constants.dart';


import 'ResponseModel/resonse_model.dart';
import 'package:http/http.dart' as http;

class APIDeleteRequest {
  static Future<ResponseModel> deleteById(String requestUrl) async {
    try {
      final response = await http.delete(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{'Accept': 'application/json', 'Content-Type': 'application/json; charset=UTF-8', 'Authorization': "$tokenType $accessToken"},
      );

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> deleteByBody(String requestUrl, dynamic data) async {
    try {
      final response = await http.delete(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{'Accept': 'application/json', 'Content-Type': 'application/json; charset=UTF-8', 'Authorization': "$tokenType $accessToken"},
        body: jsonEncode(data),
      );

      final res = ResponseModel(statusCode: response.statusCode, data: response.body);

      return res;
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }
}
