import 'package:flutter/material.dart';
import 'package:flutter_with_hive/widgets/custom_dialog.dart';



Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String description,
  IconData? icon,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Widget? content,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => CustomDialog(
      title: title,
      description: description,
      icon: icon,
      onConfirm: onConfirm,
      onCancel: onCancel,
      content: content,
    ),
  );
}
