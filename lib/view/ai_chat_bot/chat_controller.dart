import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/global.dart';
import 'package:flutter_with_hive/core/utils/api_urls.dart';
import 'package:flutter_with_hive/core/utils/print_log.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';

// Message Model
class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({required this.text, required this.isUser, required this.timestamp});
}

// Chat Controller
class AiChatBotController extends GetxController {
  static AiChatBotController get to  => Get.find(); 
  final messages = <Message>[].obs;
  final isTyping = false.obs;
  final textController = TextEditingController();
  static const String _geminiUrl = '${ApiUrls.geminiUrlFPoint}$geminiModel:generateContent';

  /// 🌐 Internet connection observable
  RxBool isOnline = false.obs;

  /// Connectivity subscription
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    messages.add(Message(text: "Hi! I'm your AI assistant 🤖. How can I help you today?", isUser: false, timestamp: DateTime.now()));
    // Start connectivity monitoring
    _initConnectivity();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////  check online conection
  ///  Initialize and listen to connectivity changes
  Future<void> _initConnectivity() async {
    // Check initial connection
    final initialResult = await Connectivity().checkConnectivity();
    isOnline.value = !_isDisconnected(initialResult);

    // Listen to connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      final onlineNow = !_isDisconnected(result);
      isOnline.value = onlineNow;
    });
  }
   /// Current connectivity type (wifi, mobile, ethernet, none, etc.)
  Rx<ConnectivityResult> connectionType = ConnectivityResult.none.obs;

  /// Human-friendly label for the current connection type
  String get connectionTypeLabel {
    switch (connectionType.value) {
      case ConnectivityResult.wifi:
        return 'Wi‑Fi';
      case ConnectivityResult.mobile:
        return 'Mobile';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.none:
        return 'None';
    }
  }

  /// Helper: Checks if the connection list means offline
  bool _isDisconnected(List<ConnectivityResult> results) {
    return results.contains(ConnectivityResult.none);
  }

  //////////////////////////////////////////////////////////////////////////////////////////////// end connection

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    messages.add(Message(text: text, isUser: true, timestamp: DateTime.now()));
    textController.clear();
    // Show typing
    isTyping.value = true;
    // Get response from Gemini
    final responseText = await _callGemini(text);

    isTyping.value = false;

    // Add bot response
    messages.add(Message(text: responseText ?? "⚠️ Sorry, I couldn't get a response right now.", isUser: false, timestamp: DateTime.now()));
  }

  /// ✅ Correct Gemini API call
  Future<String?> _callGemini(String prompt) async {
    if (geminiApiKey.isEmpty) {
      printLog("❌ Gemini API key missing");
      return null;
    }

    try {
      final uri = Uri.parse('$_geminiUrl?key=$geminiApiKey');
      final client = HttpClient();
      final request = await client.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');

      final body = jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      });

      request.add(utf8.encode(body));
      final response = await request.close();
      final respBody = await response.transform(utf8.decoder).join();
      client.close();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(respBody);
        final text = decoded["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];
        return text ?? "No response text found.";
      } else {
        printLog("❌ Gemini API error: ${response.statusCode} - $respBody");
        return "Error ${response.statusCode}: Unable to fetch response.";
      }
    } catch (e) {
      printLog("⚠️ Exception during Gemini API call: $e");
      return null;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    textController.dispose();
    super.onClose();
  }
}
