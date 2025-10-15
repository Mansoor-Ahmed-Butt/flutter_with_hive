import 'dart:convert';
 
import 'package:flutter/foundation.dart';
 
printLog(dynamic data) {
  if (kDebugMode) {
    print(data.toString());
  }
}
 
void prettyPrint(dynamic label, dynamic data) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  '); // Two spaces for indentation
  final String prettyJson = encoder.convert(data);
  printLog("$label: $prettyJson");
}