import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/widgets/custom_button/custom_tool_tip.dart';
import 'package:flutter_with_hive/widgets/text/app_branding.dart';
import 'package:flutter_with_hive/widgets/text/size_box.dart';
import 'package:flutter_with_hive/widgets/text/text_field_theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFormFieldForMultipleLine extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final double isSpaceBetween;
  final Function? validator;
  final Function? onSaved;
  final Function? onChange;
  final Function? onFieldSubmitted;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool isRequired;
  final bool isshowHelp;
  final bool showheading;
  final TextEditingController? controller;
  final Color containerColor;
  final Color textFieldColor;
  final bool extraMultiLinePadding;
  final bool isWidthForHeader;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;
  final int? maxLength;

  // final bool isHeightForChecksOnPopUp;

  const MyTextFormFieldForMultipleLine({
    super.key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChange,
    this.helpText,
    this.isPassword = false,
    this.isEmail = false,
    this.isEnabled = true,
    this.isRequired = false,
    this.isshowHelp = false,
    this.showheading = true,
    this.isSpaceBetween = 0,
    this.labelText,
    this.suffixIcon,
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.containerColor = Colors.white,
    this.textFieldColor = Colors.white,
    this.isWidthForHeader = false,
    this.containerHeight,
    this.extraMultiLinePadding = false,
    this.containerWidth,
    this.fontSizeForAll,
    this.fontSizeForLabel,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showheading)
          Row(
            children: [
              Text(
                labelText.toString(),
                style: TextFiledTheme.textStyleHeader(fontSizeForLabel),
              ),
              if (isRequired)
                Text(
                  " *",
                  style: TextFiledTheme.textStyleHeaderRequired(fontSizeForLabel),
                ),
              if (isshowHelp)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: CustomToolTip(
                    message: helpText ?? "No Content Provided by County",
                    // onTap: () {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: Text(T("pos_Help")),
                    //       content: Text(helpText ?? "No Content Provided by County"),
                    //       actions: <Widget>[
                    //         InkWell(
                    //           onTap: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(15.0),
                    //             child: Text(T("login_ok")),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // },
                    child: Icon(
                      Icons.help,
                      size: 15.sp,
                    ),
                  ),
                )
            ],
          ),
        SizedH(isSpaceBetween),
        Container(
          decoration: BoxDecoration(
            color: isEnabled ? containerColor : AppColors.lightBackgroundColor,
            borderRadius: BorderRadius.circular(Branding.tFborderR),
            border: const Border(
              left: BorderSide(width: 1, color: AppColors.borderColor),
              top: BorderSide(width: 1, color: AppColors.borderColor),
              right: BorderSide(width: 1, color: AppColors.borderColor),
              bottom: BorderSide(width: 2, color: AppColors.borderColor),
            ),
          ),
          width: containerWidth,
          height: containerHeight ?? Branding.tFHeight,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
                controller: controller,
                initialValue: intialValue,
                style: TextFiledTheme.textStyle(fontSizeForAll),

                // scrollPadding: EdgeInsets.all(0),
                maxLines: 50,
                enabled: isEnabled,
                cursorColor: Colors.black,
                decoration: TextFiledTheme.inputDecoration(
                  isPaddingForMultiLine: extraMultiLinePadding,
                  fontSizeForAll: fontSizeForAll,
                  isFieldForTable: false,
                  isZeroPadding: false,
                  hintText: hintText ?? "",
                  suffixIcon: suffixIcon,
                ),
                obscureText: isPassword ? true : false,
                validator: validator as String? Function(String?)?,
                onSaved: onSaved as void Function(String?)?,
                onChanged: onChange as void Function(String?)?,
                onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
                keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.multiline,
                inputFormatters: (maxLength != null)
                    ? [
                        LengthLimitingTextInputFormatter(maxLength), // Limits the input length to 3
                        // FilteringTextInputFormatter., // Allows only digits
                      ]
                    : []),
          ),
        ),
      ],
    );
  }
}
