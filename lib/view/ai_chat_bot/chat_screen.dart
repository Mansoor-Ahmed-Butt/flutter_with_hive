import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                        return _buildMessageBubble(context, controller.messages[index], index);
                      },
                    ),
                  ),
                  controller.isTyping.value ? _buildTypingIndicator() : const SizedBox.shrink(),
                  // Voice Status Indicator
                  Obx(
                    () => controller.isListening.value
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppColors.transparent.withValues(alpha: 0.01),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: AppColors.appPurple.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    controller.voiceText.value.isEmpty ? 'Listening...' : controller.voiceText.value,
                                    style: AppStyle.style12w500(color: AppColors.whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(height: 8.h),

                  _buildInputArea(controller, context),
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
        border: Border(bottom: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.1), width: 1)),
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

  Widget _buildMessageBubble(BuildContext context, Message message, int index) {
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
        padding: EdgeInsets.only(bottom: 16.r),
        child: Row(
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser) ...[
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppColors.appSkyBlueC, AppColors.appPurpleWshadeC]),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20.r),
              ),
              SizedBox(width: 12.w),
            ],
            Flexible(
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  gradient: message.isUser
                      ? LinearGradient(colors: [AppColors.appSkyBlueC, AppColors.appSkyBlueC.withValues(alpha: 0.7)])
                      : const LinearGradient(colors: [AppColors.appPink, AppColors.appPurple]),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: message.isUser ? AppColors.appSkyBlueC.withValues(alpha: 0.3) : AppColors.blackColor.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: message.isUser ? AppColors.appSkyBlueC.withValues(alpha: 0.3) : AppColors.whiteColor.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: SelectableText(
                  message.text,
                  style: AppStyle.style15w500(color: AppColors.whiteColor).copyWith(height: 1.4),
                  showCursor: false,
                  contextMenuBuilder: (context, EditableTextState state) {
                    return AdaptiveTextSelectionToolbar(
                      anchors: state.contextMenuAnchors,
                      children: [
                        // --- COPY BUTTON ---
                        TextButton(
                          onPressed: () {
                            final sel = state.textEditingValue.selection;
                            final text = state.textEditingValue.text;
                            final selectedText = (sel.isValid && !sel.isCollapsed) ? text.substring(sel.start, sel.end) : text;

                            Clipboard.setData(ClipboardData(text: selectedText));

                            // ✅ Clear selection after copying
                            state.userUpdateTextEditingValue(
                              state.textEditingValue.copyWith(selection: const TextSelection.collapsed(offset: -1)),
                              SelectionChangedCause.toolbar,
                            );

                            // ✅ Hide toolbar safely
                            try {
                              state.hideToolbar();
                            } catch (_) {}

                            Get.snackbar(
                              'Copied',
                              'Text copied to clipboard',
                              snackPosition: SnackPosition.TOP,
                              duration: const Duration(seconds: 2),
                              backgroundColor: AppColors.appGreenC,
                            );
                          },
                          child: const Text('Copy'),
                        ),

                        // --- SELECT ALL BUTTON ---
                        TextButton(
                          onPressed: () {
                            final fullText = state.textEditingValue.text;

                            // ✅ Select the entire text
                            state.userUpdateTextEditingValue(
                              state.textEditingValue.copyWith(selection: TextSelection(baseOffset: 0, extentOffset: fullText.length)),
                              SelectionChangedCause.toolbar,
                            );
                          },
                          child: const Text('Select All'),
                        ),
                      ],
                    );
                  },
                ),
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
              gradient: const LinearGradient(colors: [AppColors.appGreenC, AppColors.appGreyC]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.1), width: 1),
            ),
            child: SpinKitThreeBounce(color: Colors.white, size: 20.r),
            //Row(children: [_buildDot(0), const SizedBox(width: 6), _buildDot(1), const SizedBox(width: 6), _buildDot(2)]),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(AiChatBotController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.appSkyBlueC.withValues(alpha: 0.1), AppColors.appPurple.withValues(alpha: 0.1)]),
        border: Border(top: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.1), width: 1)),
      ),
      child: Row(
        children: [
          //  Voice Input Button — press-and-hold to talk, release to stop & send
          GestureDetector(
            onTapDown: (_) async {
              try {
                await controller.startListening();
              } catch (e) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: AppColors.appRedC));
              }
            },
            onTapUp: (_) async {
              try {
                await controller.stopListeningAndSend();
              } catch (e) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: AppColors.appRedC));
              }
            },
            onTapCancel: () async {
              // If the gesture is canceled (dragged off button), stop without sending
              try {
                if (controller.isListening.value) {
                  await controller.stopListeningAndSend();
                }
              } catch (e) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: AppColors.appRedC));
              }
            },
            child: Obx(() {
              final listening = controller.isListening.value;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.all(12.r),

                decoration: BoxDecoration(
                  gradient: listening
                      ? LinearGradient(colors: [Colors.redAccent, AppColors.appPink])
                      : LinearGradient(colors: [AppColors.appSkyBlueC, AppColors.appPurple]),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: listening ? AppColors.appRedC : AppColors.appSkyBlueC.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Icon(listening ? Icons.mic : Icons.mic_none, color: AppColors.whiteColor, size: 24.r),
              );
            }),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.transparent.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(28.r),
                border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.1), width: 1),
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
          SizedBox(width: 12.w),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.appSkyBlueC, AppColors.appPurple]),
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [BoxShadow(color: AppColors.appSkyBlueC.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(28.r),
                onTap: () => controller.sendMessage(controller.textController.text),
                child: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: Icon(Icons.send_rounded, color: AppColors.whiteColor, size: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
