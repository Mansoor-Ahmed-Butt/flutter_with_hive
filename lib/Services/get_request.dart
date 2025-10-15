// import 'package:global365books/core/constants/globals.dart';
// import 'package:global365books/core/utils/print_log.dart';
// import 'package:http/http.dart' as http;

// import 'ResponseModel/resonse_model.dart';

// class APIsCallGet {
//   // static Future<ResponseModel> submitRequestWithBody(
//   //     String requestUrl, dynamic data) async {
//   //   try {
//   //     // print(tokenType + " " + accessToken);
//   //     print(jsonEncode(data));
//   //     final response = await http.get(
//   //       Uri.parse(apiLink + requestUrl),
//   //       headers: <String, String>{
//   //         'Accept': 'application/json',
//   //         'Content-Type': 'application/json; charset=UTF-8',
//   //         // 'Authorization': tokenType + " " + accessToken
//   //       },
//   //       body: jsonEncode(data),
//   //     );

//   //     return ResponseModel(
//   //         statusCode: response.statusCode, data: response.body);
//   //   } catch (e) {
//   //     final res = ResponseModel(statusCode: -1, data: e.toString());
//   //     return res;
//   //   }
//   // }

//   static Future<ResponseModel> getData(String requestUrl, {String? baseUrl}) async {
//     // printLog("access token get Data$accessToken");

//     try {
//       //  printLog("Complete url is " + apiLink + requestUrl);
//       final url = baseUrl != null ? Uri.parse(baseUrl + requestUrl) : Uri.parse(apiLink + requestUrl);
//       printLog("Complete url is $url");
//       final response = await http.get(
//         url,
//         headers: <String, String>{'Accept': 'application/json', 'Authorization': "$tokenType $accessToken"},
//       );

//       final res = ResponseModel(statusCode: response.statusCode, data: response.body);

//       return res;
//     } catch (e) {
//       final res = ResponseModel(statusCode: -1, data: e.toString());
//       return res;
//     }
//   }

//   static Future<ResponseModel> getDataWithOutAuth(String requestUrl) async {
//     printLog("access token get Data$accessToken");

//     try {
//       // print(tokenType + " " + accessToken);
//       final response = await http.get(
//         Uri.parse(apiLink + requestUrl),
//         headers: <String, String>{
//           'Accept': 'application/json',
//           'Content-Type': 'application/json; charset=UTF-8',
//           // 'Authorization': "$tokenType $accessToken"
//         },
//       );

//       final res = ResponseModel(statusCode: response.statusCode, data: response.body);

//       return res;
//     } catch (e) {
//       final res = ResponseModel(statusCode: -1, data: e.toString());
//       return res;
//     }
//   }

//   static Future<ResponseModel> getDataById(String requestUrl, String id) async {
//     try {
//       printLog("Request Url==>$apiLink$requestUrl/$id");

//       final response = await http.get(
//         Uri.parse("$apiLink$requestUrl/$id"),
//         headers: <String, String>{
//           'Accept': 'application/json',
//           'Content-Type': 'application/json; charset=UTF-8',
//           // 'Authorization': tokenType + " " + accessToken
//         },
//       );

//       final res = ResponseModel(statusCode: response.statusCode, data: response.body);

//       return res;
//     } catch (e) {
//       final res = ResponseModel(statusCode: -1, data: e.toString());
//       return res;
//     }
//   }

//   static String method2() {
//     /*...*/
//     return "Some string";
//   }
// }
