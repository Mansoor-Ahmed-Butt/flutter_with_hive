import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/helper/app_texts.dart';

class TextFiledTheme {
  // DropDown Decoration
  static InputDecoration inputDecoration({
    double? fontSizeForAll,
    bool isFieldForTable = false,
    bool isZeroPadding = false,
    bool isPaddingForMultiLine = false,
    String hintText = "",
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextDirection? hintTextDirection,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: AppColors.placeHolderColor,
        fontSize: fontSizeForAll ?? 12,
        fontWeight: FontWeight.w400,
        fontFamily: AppTexts.montserratFontFaimly,
      ),
      hintTextDirection: hintTextDirection,
      isDense: true,
      border: InputBorder.none,
      contentPadding: isZeroPadding
          ? EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h)
          : isPaddingForMultiLine
          ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16)
          : EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ),
      // disabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ),
      // focusedBorder: OutlineInputBorder(

      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ), // labelText: labelText,
      // filled: true,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      // fillColor: AppColors.white,
    );
  }

  /// Display Text Stlye

  static TextStyle textStyle(double? fontSizeForAll) {
    return TextStyle(
      color: AppColors.bodyTextDark,
      fontSize: fontSizeForAll ?? 12.sp,
      fontWeight: FontWeight.w400,
      fontFamily: AppTexts.montserratFontFaimly,
    );
  }

  static TextStyle textStyleHeader(double? fontSizeForLabel) {
    return TextStyle(
      color: AppColors.titleColor,
      fontSize: fontSizeForLabel ?? 12.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppTexts.montserratFontFaimly,
    );
  }

  static TextStyle textStyleHeaderRequired(double? fontSizeForLabel) {
    return TextStyle(
      color: AppColors.red,
      fontSize: fontSizeForLabel ?? 12.sp,
      fontWeight: FontWeight.w600,
      fontFamily: AppTexts.montserratFontFaimly,
    );
  }

  /// Dropdown item Style
  static TextStyle dropDownItemStyle() {
    return TextStyle(color: AppColors.bodyTextDark, fontSize: 12.sp, fontFamily: 'Montserrat', fontWeight: FontWeight.w400);
  }
}
