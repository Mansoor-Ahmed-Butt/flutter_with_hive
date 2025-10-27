import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI ChatBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: const Color(0xFF0F0F1E), useMaterial3: true),
      home: const ChatScreen(),
    );
  }
}

// Message Model
class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({required this.text, required this.isUser, required this.timestamp});
}

// Chat Controller
class ChatController extends GetxController {
  final messages = <Message>[].obs;
  final isTyping = false.obs;
  final textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Welcome message
    messages.add(Message(text: "Hi! I'm your AI assistant. How can I help you today?", isUser: false, timestamp: DateTime.now()));
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    // Add user message
    messages.add(Message(text: text, isUser: true, timestamp: DateTime.now()));

    textController.clear();

    // Simulate bot typing
    isTyping.value = true;

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 1500), () {
      isTyping.value = false;
      messages.add(Message(text: _generateResponse(text), isUser: false, timestamp: DateTime.now()));
    });
  }

  String _generateResponse(String userMessage) {
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

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

// Chat Screen
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
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
        gradient: LinearGradient(colors: [Colors.blue.shade600.withValues(alpha: 0.2), Colors.purple.shade600.withValues(alpha: 0.2)]),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade400]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
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
                      boxShadow: [BoxShadow(color: Colors.greenAccent.withValues(alpha: 0.5), blurRadius: 8)],
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
                      : LinearGradient(colors: [const Color(0xFF1E1E2E), const Color(0xFF252535)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: message.isUser ? Colors.blue.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: message.isUser ? Colors.blue.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.1), width: 1),
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
              border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
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

  Widget _buildInputArea(ChatController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue.shade600.withValues(alpha: 0.1), Colors.purple.shade600.withValues(alpha: 0.1)]),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
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
              boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
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
