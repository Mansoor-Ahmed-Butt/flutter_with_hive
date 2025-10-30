import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_with_hive/core/themes.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    this.size = 14,
    this.svgPath,
    this.icon,
    this.onTap,
    this.isFilled = false,
    this.padding,
    this.iconColor,
    this.isOnDark = false,
    this.iconOnly = false,
  });
  final double size;
  final String? svgPath;
  final IconData? icon;
  final void Function()? onTap;
  final bool isFilled;
  final bool isOnDark;
  final bool iconOnly;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;

  myWidget(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: iconOnly ? EdgeInsets.zero : (padding ?? ((svgPath == null) ? EdgeInsets.zero : EdgeInsets.all((size / 4.66666666667)))),
      decoration: iconOnly
          ? null
          : BoxDecoration(
              color: isFilled ? (isOnDark ? AppColors.borderColor : AppColors.primaryColor) : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: isOnDark ? AppColors.whiteColor.withValues(alpha: 0.25) : AppColors.primaryColor, width: size / 28),
            ),
      child: svgPath != null
          ? SvgPicture.asset(
              svgPath ?? "assets/icons/edit.svg",
              colorFilter: ColorFilter.mode(
                iconColor ??
                    (isFilled
                        ? (isOnDark ? AppColors.borderColor : AppColors.whiteColor)
                        : (isOnDark ? AppColors.borderColor : AppColors.primaryColor)),
                BlendMode.srcIn,
              ),
            )
          : Icon(
              icon,
              color:
                  iconColor ??
                  (isFilled
                      ? (isOnDark ? AppColors.borderColor : AppColors.whiteColor)
                      : (isOnDark ? AppColors.borderColor : AppColors.primaryColor)),
              size: iconOnly ? size : (size - ((size / 4.66666666667) * 2)),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (onTap == null) ? myWidget(context) : InkWell(onTap: onTap, child: myWidget(context));
  }
}
