import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class LogInController extends GetxController {
  static LogInController get to => Get.find<LogInController>();
  RxBool isPasswordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
