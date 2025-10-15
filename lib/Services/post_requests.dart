import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_with_hive/core/utils/print_log.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter_with_hive/Services/ResponseModel/FileModel/multipart_file_model.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:http/http.dart' as http;

import 'ResponseModel/resonse_model.dart';

class APIsCallPost {
  static Future<ResponseModel> submitRequest(String requestUrl, dynamic data) async {
    try {
      printLog("$tokenType $accessToken");

      printLog("Data:${jsonEncode(data)}");
      // printLog("Data:$requestUrl");
      printLog("Link for request url:$apiLink$requestUrl");

      final response = await http.post(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$tokenType $accessToken",
        },
        body: jsonEncode(data),
      );
      printLog(response.body);

      if (response.statusCode == 500) {
        dynamic res = jsonDecode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }


  static Future<ResponseModel> submitRequestWithFile(String requestUrl, Map<String, String>? data, List<MultiPartFileModel> list) async {
    try {
      // printLog(tokenType + " " + accessToken);
      printLog("Data of the image is:${list.length}");
      // printLog("Data:${jsonEncode(data)}");
      printLog("Link:$apiLink$requestUrl");
      var headers = {'Authorization': '$tokenType $accessToken'};
      final request = http.MultipartRequest('POST', Uri.parse(apiLink + requestUrl));
      if (data != null) {
        request.fields.addAll(data);
      }
      for (int i = 0; i < list.length; i++) {
        final fileBytes = list[i].fileBytes;
        final fileName = list[i].fileName;
        // final mimeType = list[i].mimeType;
        final multipartFile = http.MultipartFile.fromBytes('file', fileBytes, filename: fileName, contentType: MediaType.parse("image/png"));
        request.files.add(multipartFile);
      }

      printLog("request==fjerjfbe======${request.send()}");

      request.headers.addAll(headers);
      final response = await request.send();
      printLog("response.statusCode in the post request with file====${response.statusCode}");
      if (response.statusCode == 500) {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());

        return ResponseModel(statusCode: response.statusCode, data: res);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static Future<ResponseModel> sendEmailFormData({
    required String reportType,
    required String toTec,
    required String subjectTec,
    required String ccTec,
    required String bccTec,
    required String messageBodyTec,
    required Uint8List pdfData,
    Map<String, dynamic>? reportData,
    String? customApiUrl,
    bool includeReportData = true,
    bool isEInvoice = false,
  }) async {
    try {
      final String fullApiUrl = customApiUrl ?? '${apiLink}Email/SendReportEmail?Type=$reportType&CompanyId=$companyId';

      printLog(fullApiUrl);

      printLog("reportData=====$toTec");
      printLog("reportData=====$ccTec");
      printLog("reportData=====$bccTec");
      printLog("reportData=====$subjectTec");

      // Headers (add Authorization if required)
      var headers = {'Authorization': '$tokenType $accessToken'};

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(fullApiUrl));
      request.fields['to'] = toTec;
      request.fields['subject'] = subjectTec;
      request.fields['cc'] = ccTec;
      request.fields['bcc'] = bccTec;
      request.fields['body'] = messageBodyTec;
      if (isEInvoice) {
        request.fields['paymentOptions'] = "both";
      }

      // Only include reportData if includeReportData is true
      if (includeReportData) {
        request.fields['reportdata'] = json.encode(reportData);
      }

      // Add the PDF file
      request.files.add(http.MultipartFile.fromBytes('attachment', pdfData, filename: reportType, contentType: MediaType('application', 'pdf')));

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 500) {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 400) {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());
        return ResponseModel(statusCode: response.statusCode, data: res);
      } else if (response.statusCode == 401) {
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());
        return ResponseModel(statusCode: response.statusCode, data: res);
      } else {
        Map<String, dynamic> res = json.decode(await response.stream.bytesToString());
        return ResponseModel(statusCode: response.statusCode, data: res["error"] ?? 'Unknown error');
      }
    } catch (e) {
      printLog('Error: $e');
      return ResponseModel(statusCode: -1, data: e.toString());
    }
  }

  static Future<ResponseModel> submitRequestWithOutAuth(String requestUrl, dynamic data) async {
    try {
      // printLog(tokenType + " " + accessToken);

      printLog("Data:${jsonEncode(data)}");
      // printLog("Link:$apiLink$requestUrl");

      final response = await http.post(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': "$tokenType $accessToken"
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 500) {
        dynamic res = jsonDecode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  ///////////// for Stripe payment
  ///1 without body

  static Future<ResponseModel> payStripWithOutBody(String requestUrl) async {
    try {
      printLog("Link:$apiLink$requestUrl");

      final response = await http.post(Uri.parse(apiLink+requestUrl), headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'});

      if (response.statusCode == 500) {
        dynamic res = jsonDecode(response.body);

        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");

        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }
///2 with body
  static Future<ResponseModel> payStripWithBody(String requestUrl, dynamic data) async {
    try {
      // printLog("$tokenType $accessToken");

      printLog("Data:${jsonEncode(data)}");
      // printLog("Data:$requestUrl");
      printLog("Link for request url:$apiLink$requestUrl");

      final response = await http.post(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': "$tokenType $accessToken",
        },
        body: jsonEncode(data),
      );
      printLog(response.body);

      if (response.statusCode == 500) {
        dynamic res = jsonDecode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }
//////////////////////////////
  static Future<ResponseModel> submitRequestWithOutBody(String requestUrl) async {
    try {
      // printLog(tokenType + " " + accessToken);

      // printLog("Data:${jsonEncode(data)}");
      printLog("Link:$apiLink$requestUrl");

      final response = await http.post(
        Uri.parse(apiLink + requestUrl),

        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "$tokenType $accessToken",
        },
        // body: jsonEncode(data),
      );

      if (response.statusCode == 500) {
        dynamic res = jsonDecode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }


  static Future<ResponseModel> submitRequestWithOutBodyWithOutAuth(String requestUrl) async {
    try {
      // printLog(tokenType + " " + accessToken);

      // printLog("Data:${jsonEncode(data)}");
      printLog("Link:$apiLink$requestUrl");

      final response = await http.post(
        Uri.parse(apiLink + requestUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization': "$tokenType $accessToken"
        },
        // body: jsonEncode(data),
      );

      if (response.statusCode == 500) {
        dynamic res = jsonDecode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: res["Result"].toString());
      } else if (response.statusCode == 401) {
        // MyToast.error("Unauthorized User");
        return ResponseModel(statusCode: response.statusCode, data: "Unauthorized User");
      } else if (response.statusCode == 403) {
        // MyToast.error("Forbidden Access");
        return ResponseModel(statusCode: response.statusCode, data: "Forbidden Access");
      } else {
        return ResponseModel(statusCode: response.statusCode, data: response.body);
      }
    } catch (e) {
      final res = ResponseModel(statusCode: -1, data: e.toString());
      return res;
    }
  }

  static String method2() {
    /*...*/
    return "Some string";
  }
}
