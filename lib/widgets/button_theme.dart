import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/themes.dart';

enum ButtonVariant {
  outlineWhite,
  outlineWhite25,
  outlineBodyText,
  outlineBorderColor,
  outlineBodyTextDark,
  outlinePrimary,
  outlineSecondary,
  outlineTitleColorWithBorder,

  emptyUnderLineWithSecondary,

  filledWhite,
  filledBodyText,
  filledBodyTextDark,
  filledPrimary,
  filledSecondary,

  filledWhiteWithPrimary,
  filledWhiteWithSecondary,
  filledPrimaryWithBodyText,
  filledPrimaryWithWhiteBodyText,

  filledPrimaryWithBodyTextDark,

  filledOrangeWithPrimaryColorIconAndText,
}

class ButtonThemeCustom {
  static ButtonColorPalete getTheme(ButtonVariant? variant) {
    switch (variant) {
      case ButtonVariant.outlineWhite:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.whiteColor,
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.outlineWhite25:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.whiteColor.withValues(alpha: 0.25),
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.outlineBodyText:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.bodyText,
          borderColor: AppColors.bodyText,
          iconColor: AppColors.bodyText,
        );
      case ButtonVariant.outlineBorderColor:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.borderColor,
          borderColor: AppColors.borderColor,
          iconColor: AppColors.borderColor,
        );
      case ButtonVariant.outlineBodyTextDark:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.bodyTextDark,
          borderColor: AppColors.bodyTextDark,
          iconColor: AppColors.bodyTextDark,
        );
      case ButtonVariant.outlinePrimary:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.primaryColor,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.primaryColor,
        );
      case ButtonVariant.outlineTitleColorWithBorder:
        return ButtonColorPalete(
          backgroundColor: AppColors.lightBackgroundColor,
          textColor: AppColors.titleColor,
          borderColor: AppColors.borderColor,
          iconColor: AppColors.titleColor,
        );
      case ButtonVariant.outlineSecondary:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.secondaryColorOrange,
          borderColor: AppColors.secondaryColorOrange,
          iconColor: AppColors.secondaryColorOrange,
        );
      case ButtonVariant.filledWhite:
        return ButtonColorPalete(
          backgroundColor: AppColors.whiteColor,
          textColor: AppColors.blackColor,
          borderColor: AppColors.whiteColor,
          iconColor: AppColors.blackColor,
        );
      case ButtonVariant.filledBodyText:
        return ButtonColorPalete(
          backgroundColor: AppColors.bodyText,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.bodyText,
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.filledBodyTextDark:
        return ButtonColorPalete(
          backgroundColor: AppColors.bodyTextDark,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.bodyTextDark,
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.filledPrimary:
        return ButtonColorPalete(
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.filledSecondary:
        return ButtonColorPalete(
          backgroundColor: AppColors.secondaryColorOrange,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.secondaryColorOrange,
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.filledWhiteWithPrimary:
        return ButtonColorPalete(
          backgroundColor: AppColors.whiteColor,
          textColor: AppColors.primaryColor,
          borderColor: AppColors.whiteColor,
          iconColor: AppColors.primaryColor,
        );
      case ButtonVariant.filledWhiteWithSecondary:
        return ButtonColorPalete(
          backgroundColor: AppColors.whiteColor,
          textColor: AppColors.secondaryColorOrange,
          borderColor: AppColors.whiteColor,
          iconColor: AppColors.secondaryColorOrange,
        );
      case ButtonVariant.filledPrimaryWithBodyText:
        return ButtonColorPalete(
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.bodyText,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.bodyText,
        );
      case ButtonVariant.filledPrimaryWithBodyTextDark:
        return ButtonColorPalete(
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.bodyTextDark,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.bodyTextDark,
        );
      case ButtonVariant.filledPrimaryWithWhiteBodyText:
        return ButtonColorPalete(
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.primaryColor,
          iconColor: AppColors.whiteColor,
        );
      case ButtonVariant.filledOrangeWithPrimaryColorIconAndText:
        return ButtonColorPalete(
          backgroundColor: AppColors.secondaryColorOrange,
          textColor: AppColors.primaryColor,
          borderColor: AppColors.secondaryColorOrange,
          iconColor: AppColors.primaryColor,
        );
      case ButtonVariant.emptyUnderLineWithSecondary:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.secondaryColorOrange,
          borderColor: Colors.transparent,
          iconColor: AppColors.secondaryColorOrange,
        );

      default:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: AppColors.whiteColor,
          borderColor: AppColors.whiteColor,
          iconColor: AppColors.whiteColor,
        );
    }
  }
}

class ButtonColorPalete {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color iconColor;

  ButtonColorPalete({required this.backgroundColor, required this.textColor, required this.borderColor, required this.iconColor});
}
