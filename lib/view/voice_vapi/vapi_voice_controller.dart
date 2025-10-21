import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VapiVoiceController extends GetxController {
  // Observables
  final messages = <Map<String, String>>[].obs;
  final isLoading = false.obs;
  final isListening = false.obs;
  final voiceText = ''.obs;

  // Input controller owned by the GetX controller so the widget does not
  // have to manage a local TextEditingController. voiceText changes are
  // mirrored into this controller so interim STT results appear live.
  final TextEditingController inputController = TextEditingController();

  // Speech
  late stt.SpeechToText _speechToText;

  // Keys / config - replace these with secure source before production
  String apiKey = '2bfb4957-fa34-4e2f-947a-a978ff5901ba'; // PRIVATE token expected
  String assistantId = 'd01cf2c7-6f67-4a6c-872e-571a5193c009';

  @override
  void onInit() {
    super.onInit();
    _speechToText = stt.SpeechToText();
    _initSpeech();
    // Mirror voiceText into the input field so the UI shows interim results
    // without the widget needing to bind a controller.
    ever(voiceText, (String v) {
      if (inputController.text != v) {
        inputController.text = v;
        inputController.selection = TextSelection.fromPosition(TextPosition(offset: inputController.text.length));
      }
    });
  }

  @override
  void onClose() {
    _speechToText.stop();
    inputController.dispose();
    super.onClose();
  }

  Future<void> _initSpeech() async {
    await _speechToText.initialize();
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception('Microphone permission not granted');
    }
  }

  Future<void> toggleListening() async {
    if (isListening.value) {
      await _speechToText.stop();
      isListening.value = false;
      if (voiceText.value.isNotEmpty) {
        await sendMessage(voiceText.value);
        voiceText.value = '';
      }
    } else {
      final status = await Permission.microphone.status;
      if (!status.isGranted) {
        await requestMicrophonePermission();
        return;
      }

      final available = await _speechToText.initialize();
      if (!available) throw Exception('Speech recognition not available');

      isListening.value = true;
      _speechToText.listen(
        onResult: (result) {
          voiceText.value = result.recognizedWords;
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  /// Bind a Flutter [TextEditingController] so live speech text is mirrored
  /// into the UI text field. This simply listens to the [voiceText] Rx and
  /// writes the value into the provided controller.
  // NOTE: bindTextController removed. Use `inputController` on the controller
  // instance directly from the UI (e.g. `controller.inputController`).

  Future<void> sendMessage(String text) async {
    isLoading.value = true;
    messages.add({'role': 'user', 'text': text});

    // Quick guard: public vs private key confusion
    // If your web widget uses a public key, ensure apiKey here is the PRIVATE token.
    final url = Uri.parse('https://api.vapi.ai/chat');
    final payload = {'assistantId': assistantId, 'input': text};

    try {
      final resp = await http.post(url, headers: {'Authorization': 'Bearer $apiKey', 'Content-Type': 'application/json'}, body: jsonEncode(payload));

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final body = jsonDecode(resp.body);
        // The docs show a variety of response shapes; try common fields
        final reply = body['message'] ?? body['response'] ?? (body['output'] is List ? body['output'].first['text'] : null) ?? body.toString();
        messages.add({'role': 'assistant', 'text': reply.toString()});
      } else {
        messages.add({'role': 'assistant', 'text': 'Error: ${resp.statusCode} - ${resp.body}'});
      }
    } catch (e) {
      messages.add({'role': 'assistant', 'text': 'Connection error: $e'});
    }

    // Clear any intermediate voice text and stop the listening indicator.
    voiceText.value = '';
    isListening.value = false;
    isLoading.value = false;
  }
}
