import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vapi_voice_controller.dart';

class VapiChatScreen extends StatelessWidget {
  VapiChatScreen({super.key});

  final VapiVoiceController controller = Get.put(VapiVoiceController());

  // Auto scroll to bottom when new message arrives

  // No local animation controller used in the refactored GetX screen.

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    ever(controller.messages, (_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
    });
    // Use the controller's owned TextEditingController so the widget doesn't
    // need to manage lifecycle or binding logic. Interim STT results are
    // mirrored into `controller.inputController` by the controller.
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        title: const Text('Vapi Assistant'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => controller.messages.clear(), tooltip: 'Clear chat')],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(() {
              final msgs = controller.messages;
              if (msgs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey[600]),
                      const SizedBox(height: 16),
                      Text('Start a conversation', style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Type or use voice input', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: msgs.length,
                itemBuilder: (context, index) {
                  final msg = msgs[index];
                  final isUser = msg['role'] == 'user';
                  return _buildMessageBubble(msg, isUser, index);
                },
              );
            }),
          ),

          // Loading Indicator
          Obx(
            () => controller.isLoading.value
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)),
                        ),
                        const SizedBox(width: 12),
                        const Text('Assistant is typing...', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Voice Status Indicator
          Obx(
            () => controller.isListening.value
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.voiceText.value.isEmpty ? 'Listening...' : controller.voiceText.value,
                            style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Voice Input Button
                  GestureDetector(
                    onTap: () async {
                      try {
                        await controller.toggleListening();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
                      }
                    },
                    child: Obx(() {
                      final listening = controller.isListening.value;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: listening
                              ? const LinearGradient(colors: [Colors.red, Colors.redAccent])
                              : LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple.shade700]),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: (listening ? Colors.red : Colors.deepPurple).withValues(alpha: 0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(listening ? Icons.mic : Icons.mic_none, color: Colors.white, size: 24),
                      );
                    }),
                  ),
                  const SizedBox(width: 12),

                  // Text Input
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D3E),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: TextField(
                        controller: controller.inputController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          hintText: 'Type or speak your message...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (text) {
                          if (text.trim().isNotEmpty) {
                            controller.sendMessage(text.trim());
                            controller.inputController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Send Button
                  GestureDetector(
                    onTap: () {
                      final text = controller.inputController.text.trim();
                      if (text.isNotEmpty) {
                        controller.sendMessage(text);
                        controller.inputController.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple.shade700]),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.deepPurple.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, String> msg, bool isUser, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
        );
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(Get.context!).size.width * 0.75),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            gradient: isUser
                ? LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple.shade700])
                : const LinearGradient(colors: [Color(0xFF2D2D3E), Color(0xFF3A3A4E)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: (isUser ? Colors.deepPurple : Colors.black).withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2)),
            ],
          ),
          child: Text(msg['text']!, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
        ),
      ),
    );
  }
}
