import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_controller.dart';

class AiChatbotScreen extends StatelessWidget {
  const AiChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AiChatBotController controller = Get.put(AiChatBotController());
    final ScrollController scrollController = ScrollController();

    // Auto scroll to bottom when new message arrives
    ever(controller.messages, (_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF0F0F1E), const Color(0xFF1A1A2E), const Color(0xFF16213E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(controller.messages[index], index);
                    },
                  ),
                ),
              ),
              Obx(() => controller.isTyping.value ? _buildTypingIndicator() : const SizedBox.shrink()),
              _buildInputArea(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue.shade600.withOpacity(0.2), Colors.purple.shade600.withOpacity(0.2)]),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade400]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI Assistant',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [BoxShadow(color: Colors.greenAccent.withOpacity(0.5), blurRadius: 8)],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Online', style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message, int index) {
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade400]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: message.isUser
                      ? LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade400])
                      : const LinearGradient(colors: [Color(0xFF1E1E2E), Color(0xFF252535)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: message.isUser ? Colors.blue.withOpacity(0.3) : Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: message.isUser ? Colors.blue.withOpacity(0.3) : Colors.white.withOpacity(0.1), width: 1),
                ),
                child: Text(message.text, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4)),
              ),
            ),
            if (message.isUser) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade400]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1E1E2E), Color(0xFF252535)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
            child: Row(children: [_buildDot(0), const SizedBox(width: 6), _buildDot(1), const SizedBox(width: 6), _buildDot(2)]),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        final delay = index * 0.2;
        final animValue = ((value + delay) % 1.0);
        return Transform.translate(
          offset: Offset(0, -6 * (1 - (animValue * 2 - 1).abs())),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(4)),
          ),
        );
      },
    );
  }

  Widget _buildInputArea(AiChatBotController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue.shade600.withOpacity(0.1), Colors.purple.shade600.withOpacity(0.1)]),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
              ),
              child: TextField(
                controller: controller.textController,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                onSubmitted: (value) => controller.sendMessage(value),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade600, Colors.purple.shade600]),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () => controller.sendMessage(controller.textController.text),
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(Icons.send_rounded, color: Colors.white, size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
