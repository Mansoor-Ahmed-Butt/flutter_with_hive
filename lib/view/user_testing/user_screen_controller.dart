
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserScreenController extends GetxController {
  static UserScreenController get to => Get.find();

  late final WebViewController webController;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (_) => isLoading.value = false));

    loadLocalHtml();
  }

  Future<void> loadLocalHtml({String assetPath = 'assets/html/sample_1.html'}) async {
    try {
      final html = await rootBundle.loadString(assetPath);
      final base64Data = base64Encode(const Utf8Encoder().convert(html));
      final uri = 'data:text/html;base64,$base64Data';
      await webController.loadRequest(Uri.parse(uri));
    } catch (e) {
      final errHtml = '<html><body><h3>Unable to load local HTML</h3><p>$e</p></body></html>';
      final base64Data = base64Encode(const Utf8Encoder().convert(errHtml));
      final uri = 'data:text/html;base64,$base64Data';
      await webController.loadRequest(Uri.parse(uri));
      isLoading.value = false;
    }
  }
}
