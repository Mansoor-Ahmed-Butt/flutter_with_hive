
import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/responsive.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';




//Chat Model
const String geminiModel = 'gemini-2.5-flash';
 // 🔑 Gemini API key (replace with your regenerated one, never commit it to Git)
 const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyDI2OdFFyLV00S6-JFv9rDzBv9IVaGCvIU', // <-- replace with your new key
  );