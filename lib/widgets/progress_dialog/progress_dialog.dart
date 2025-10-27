import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/helper/app_assets.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProgressDialogCustom {
  ProgressDialogCustom(this.context, {Key? key});
  BuildContext context;
  bool _fallbackDialogShown = false;
  void show() {
    try {
      // If a GlobalLoaderOverlay ancestor exists, use it. Otherwise fall back to a dialog.
      final hasOverlay = context.findAncestorWidgetOfExactType<GlobalLoaderOverlay>() != null;
      if (hasOverlay) {
        context.loaderOverlay.show(
          widgetBuilder: (progress) => Stack(
            children: [
              Container(color: Colors.black.withValues(alpha: 0.4)),
              Center(
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: AppColors.activityColor.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(15.0)),
                  child: _imageWidget(AppAssets.logo),
                ),
              ),
            ],
          ),
        );
      } else {
        // Fallback: show a modal dialog so hide() can dismiss it later
        _fallbackDialogShown = true;
        showDialog<void>(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.4),
          barrierDismissible: false,
          useRootNavigator: true,
          builder: (ctx) => Center(
            child: Container(
              height: 120.0,
              width: 120.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: AppColors.activityColor.withValues(alpha: 0.75), borderRadius: BorderRadius.circular(15.0)),
              child: _imageWidget(AppAssets.logo),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error in showing loader: ${e.toString()}');
    }
  }

  void hide() {
    try {
      final hasOverlay = context.findAncestorWidgetOfExactType<GlobalLoaderOverlay>() != null;
      if (hasOverlay) {
        if (context.mounted && context.loaderOverlay.visible) {
          context.loaderOverlay.hide();
        }
      } else {
        if (_fallbackDialogShown) {
          try {
            if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
          } catch (_) {}
          _fallbackDialogShown = false;
        }
      }
    } catch (e) {
      debugPrint('Error in hiding loader: ${e.toString()}');
    }
  }

  Widget _imageWidget(String assetPath) {
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(assetPath, fit: BoxFit.contain);
    }
    return Image.asset(assetPath, fit: BoxFit.contain);
  }
}
