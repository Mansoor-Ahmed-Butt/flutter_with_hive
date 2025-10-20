import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'user_screen_controller.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(UserScreenController());

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
          child: Center(
            child: SizedBox(
              width: 300.w,
              height: 400.h,
              child: Stack(
                children: [
                  // Text("Hello world"),
                  WebViewWidget(controller: ctrl.webController),
                  Obx(() => ctrl.isLoading.value ? const Center(child: CircularProgressIndicator()) : const SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
