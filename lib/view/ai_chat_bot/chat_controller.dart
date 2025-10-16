import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
  final messages = <Message>[].obs;
  final isTyping = false.obs;
  final textController = TextEditingController();

  // Gemini / Generative Language API config.
  // It's recommended to pass the API key at runtime via --dart-define=GEMINI_API_KEY=your_key
  // For convenience this falls back to the key provided (you can override with dart-define).
  static const String _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'AIzaSyDI2OdFFyLV00S6-JFv9rDzBv9IVaGCvIU');

  static const String _geminiModel = 'text-bison-001';
  static const String _geminiUrl = 'https://generativelanguage.googleapis.com/v1beta2/models/$_geminiModel:generate';

  @override
  void onInit() {
    super.onInit();
    // Welcome message
    messages.add(Message(text: "Hi! I'm your AI assistant. How can I help you today?", isUser: false, timestamp: DateTime.now()));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    messages.add(Message(text: text, isUser: true, timestamp: DateTime.now()));

    textController.clear();

    // Indicate bot is typing while we wait for Gemini
    isTyping.value = true;

    // Call Gemini API and append response. If Gemini fails, fall back to the local generator.
    final responseFromGemini = await _callGemini(text);
    final response = responseFromGemini ?? _generateResponse(text);

    isTyping.value = false;
    messages.add(Message(text: response, isUser: false, timestamp: DateTime.now()));
  }

  String _generateResponse(String userMessage) {
    // Deprecated: local fallback kept for reference. New implementation uses Gemini.
    final lower = userMessage.toLowerCase();

    if (lower.contains('hello') || lower.contains('hi')) {
      return "Hello! How are you doing today?";
    } else if (lower.contains('how are you')) {
      return "I'm doing great, thank you for asking! How can I assist you?";
    } else if (lower.contains('help')) {
      return "I'm here to help! You can ask me questions, have a conversation, or just chat about anything you'd like.";
    } else if (lower.contains('bye')) {
      return "Goodbye! Have a wonderful day! Feel free to come back anytime.";
    } else {
      return "That's interesting! Tell me more about that, or feel free to ask me anything else.";
    }
  }

  /// Calls Google's Generative Language API (Gemini) using an API key.
  /// Returns the model's text or a helpful error message.
  /// Calls Google's Generative Language API (Gemini) using an API key.
  /// Returns the model's text, or null if the call failed (in which case callers should use a fallback).
  Future<String?> _callGemini(String prompt) async {
    if (_geminiApiKey.isEmpty) {
      return null;
    }

    try {
      final uri = Uri.parse('$_geminiUrl?key=$_geminiApiKey');
      final client = HttpClient();
      final request = await client.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');

      final body = jsonEncode({
        'prompt': {'text': prompt},
        'maxOutputTokens': 256,
        'temperature': 0.2,
      });

      request.add(utf8.encode(body));
      final response = await request.close();
      final respBody = await response.transform(utf8.decoder).join();
      client.close();

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(respBody);

        // Try common response shapes used by the API
        if (decoded.containsKey('candidates') && decoded['candidates'] is List && decoded['candidates'].isNotEmpty) {
          final cand = decoded['candidates'][0];
          if (cand is Map) {
            return (cand['output'] ?? cand['content'] ?? cand['text'] ?? '') as String;
          }
        }

        if (decoded.containsKey('output')) return decoded['output'].toString();
        if (decoded.containsKey('content')) return decoded['content'].toString();

        return jsonEncode(decoded);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
