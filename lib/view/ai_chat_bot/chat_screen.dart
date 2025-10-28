import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/core/utils/print_log.dart';
import 'package:flutter_with_hive/view/home_page/main_home_screen_controller.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF0F0F1E), const Color(0xFF1A1A2E), const Color(0xFF16213E)],
            ),
          ),
          child: SafeArea(
            child: Obx(
              () => Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.all(16.r),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageBubble(controller.messages[index], index);
                      },
                    ),
                  ),
                  controller.isTyping.value ? _buildTypingIndicator() : const SizedBox.shrink(),
                  _buildInputArea(controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.appPink.withValues(alpha: 0.2), AppColors.appPurple.withValues(alpha: 0.2)]),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              MainHomeScreenController.to.currentIndex.value = 0;
              Get.delete<AiChatBotController>();

              printLog("Backe to Main screen");
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.appPink, AppColors.appPurple]),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20.r),
            ),
          ),

          SizedBox(width: 16.w),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.appPink, AppColors.appPurple]),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [BoxShadow(color: AppColors.appPink.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 28.r),
          ),
          SizedBox(width: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AI Assistant By Mansoor', style: AppStyle.style20w700(color: AppColors.whiteColor)),

              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: AiChatBotController.to.isOnline.value ? AppColors.appGreenC : AppColors.appRedC,
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [BoxShadow(color: AppColors.appGreenC.withValues(alpha: 0.5), blurRadius: 8)],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(AiChatBotController.to.isOnline.value ? 'Online' : "Offline", style: AppStyle.style14w400(color: AppColors.appGreyC)),
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
                      color: message.isUser ? Colors.blue.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: message.isUser ? Colors.blue.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.1), width: 1),
                ),
                child: Text(message.text, style: AppStyle.style15w500(color: AppColors.whiteColor).copyWith(height: 1.4)),
              ),
            ),
            if (message.isUser) ...[
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(12.r)),
                child: Icon(Icons.person_rounded, color: Colors.white, size: 20.r),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.appPink, AppColors.appPurple]),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1E1E2E), Color(0xFF252535)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
            ),
            child: SpinKitThreeBounce(color: Colors.white, size: 20.r),
            //Row(children: [_buildDot(0), const SizedBox(width: 6), _buildDot(1), const SizedBox(width: 6), _buildDot(2)]),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(AiChatBotController controller) {
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
                  hintStyle: AppStyle.style15w500(color: AppColors.appGreyC),

                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
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
