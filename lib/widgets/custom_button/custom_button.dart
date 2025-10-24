import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/widgets/button_theme.dart';
import 'package:flutter_with_hive/widgets/custom_button/label_semi_bold.dart';
import 'package:flutter_with_hive/widgets/text/app_branding.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.bColor,
    this.isIcon = false,
    this.isIconLeft = true,
    this.isOnDark = false,
    this.onlyIcon = false,
    this.icon,
    this.svgPath,
    this.extraPadding = false,
    this.extraSmallPaddingVertical = false,
    this.isSaveButton = false,
    this.variant,
    this.hoveredVariant,
    this.isUnderLine = false,
    this.isButtonInHeader = false,
    this.customPadding,
    this.textStyle,
    this.borderRadius,
    this.key1,
  });
  final Function()? onTap;
  final String btnText;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? bColor;
  final bool isIcon;
  final bool isIconLeft;
  final bool extraPadding;
  final bool extraSmallPaddingVertical;
  final bool isOnDark;
  final bool onlyIcon;
  final bool isSaveButton;
  final IconData? icon;
  final String? svgPath;
  final ButtonVariant? variant;
  final ButtonVariant? hoveredVariant;
  final bool isUnderLine;
  final bool isButtonInHeader;
  final EdgeInsets? customPadding;
  final TextStyle? textStyle;
  final Key? key1;
  final double? borderRadius;

  final RxBool isHovered = false.obs;
  @override
  Widget build(BuildContext context) {
    // Visual properties are computed locally inside the Obx below so we do
    // not mutate the widget's (final) fields. This keeps the widget
    // immutable (as required by StatelessWidget).

    Widget widget() {
      return Obx(() {
        // compute effective colors locally for this build
        Color? bg = backgroundColor;
        Color? txt = textColor;
        Color? ic = iconColor;
        Color? br = bColor;

        if (isHovered.value && hoveredVariant != null) {
          ButtonColorPalete colorPalete = ButtonThemeCustom.getTheme(hoveredVariant);
          bg = colorPalete.backgroundColor;
          txt = colorPalete.textColor;
          ic = colorPalete.iconColor;
          br = colorPalete.borderColor;
        } else if (variant != null) {
          ButtonColorPalete colorPalete = ButtonThemeCustom.getTheme(variant);
          bg = colorPalete.backgroundColor;
          txt = colorPalete.textColor;
          ic = colorPalete.iconColor;
          br = colorPalete.borderColor;
        }

        return Container(
          padding: customPadding ?? EdgeInsets.symmetric(horizontal: extraPadding ? 12 : 6, vertical: extraSmallPaddingVertical ? 4 : 5),
          decoration: isSaveButton
              ? BoxDecoration(
                  color: bg ?? (isOnDark ? Colors.transparent : AppColors.lightBackgroundColor),
                  border: isButtonInHeader
                      ? Border.all(color: Colors.white.withOpacity(0.25))
                      : Border(right: BorderSide(color: Colors.white.withOpacity(0.25))),
                  // border: Border.all(color: Colors.white.withOpacity(0.5)),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Branding.tFborderR), topLeft: Radius.circular(Branding.tFborderR)),
                )
              : ShapeDecoration(
                  color: bg ?? (isOnDark ? Colors.transparent : AppColors.lightBackgroundColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? Branding.tFborderR),
                    side: BorderSide(color: br ?? (isOnDark ? AppColors.whiteColor.withOpacity(0.25) : AppColors.borderColor)),
                  ),
                ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isIconLeft)
                  if (icon != null || svgPath != null)
                    (icon != null)
                        ? Tooltip(
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6)),
                            // borderColor: Colors.transparent,
                            message: onlyIcon ? btnText : "",
                            // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            textStyle: textStyle ?? const TextStyle(color: Colors.white),
                            // position: TooltipPosition.bottom,
                            child: Icon(icon, color: ic ?? (isOnDark ? AppColors.whiteColor : AppColors.bodyTextDark), size: 16),
                          )
                        : Tooltip(
                            message: btnText != "" ? btnText : "",
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(6)),
                            textStyle: textStyle ?? const TextStyle(color: Colors.white),
                            // position: TooltipPosition.bottom,
                            child: SvgPicture.asset(
                              svgPath ?? "",
                              width: 14,
                              height: 14,
                              color: ic ?? (isOnDark ? AppColors.whiteColor : AppColors.bodyTextDark),
                            ),
                          ),
                if (icon != null || svgPath != null)
                  if (isIconLeft && !onlyIcon) SizedBox(width: 4),
                if (!onlyIcon)
                  LabelSemiBold(
                    isUnderLine: isUnderLine,
                    btnText,
                    style: textStyle,
                    color: txt ?? (isOnDark ? AppColors.whiteColor : AppColors.bodyTextDark),
                  ),
                if (icon != null || svgPath != null)
                  if (!isIconLeft) SizedBox(width: 4),
                if (!isIconLeft)
                  if (icon != null || svgPath != null)
                    (icon != null)
                        ? Icon(icon, color: ic ?? (isOnDark ? AppColors.whiteColor : AppColors.bodyTextDark), size: 16)
                        : SvgPicture.asset(
                            svgPath ?? "",
                            width: 14,
                            height: 14,
                            color: ic ?? (isOnDark ? AppColors.whiteColor : AppColors.bodyTextDark),
                          ),
              ],
            ),
          ),
        );
      });
    }

    return Material(
      color: Colors.transparent,
      child: onTap == null
          ? widget()
          : InkWell(
              key: key1,
              onTap: onTap,
              onHover: (isHovered) {
                this.isHovered.value = isHovered;
              },
              // mouseCursor: SystemMouseCursors.grab,
              child: widget(),
            ),
    );
  }
}
