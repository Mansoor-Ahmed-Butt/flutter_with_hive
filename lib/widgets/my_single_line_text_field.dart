import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/widgets/custom_button/custom_tool_tip.dart';
import 'package:flutter_with_hive/widgets/text/app_branding.dart';
import 'package:flutter_with_hive/widgets/text/text_field_theme.dart';

class MyTextFieldForSingleLine extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? validator;
  final Function? onSaved;
  final Function? onChange;
  final Function? onEditingComplete;
  final int? maxLine;
  final Function? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool isRed;
  final bool isRequired;
  final bool isshowHelp;
  final bool showheading;
  final TextEditingController? controller;
  final Color containerColor;
  final Color? textFieldColor;
  final bool isWidthForHeader;
  final bool isAutoFocus;
  final bool isNumberOnly;
  final bool isZeroPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isFilled;
  final bool isForTimeSheet;
  final bool isCustomHeight;
  final bool cvvNumber;
  final bool cardNumber;
  final bool cardExpiry;
  final bool isInValid;
  final int? maxLength;

  final double? paddingBelowHeading;
  final FocusNode? focusNode;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;

  final TextStyle? textStyleOfAll;
  final bool isFieldForTable;
  final void Function()? onTap;

  final bool? isFIEN;
  final bool? isSUEmpPTAN;

  const MyTextFieldForSingleLine({
    super.key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.maxLine = 1,
    this.onChange,
    this.onEditingComplete,
    this.helpText,
    this.isPassword = false,
    this.isEmail = false,
    this.cvvNumber = false,
    this.cardNumber = false,
    this.cardExpiry = false,
    this.isEnabled = true,
    this.isRed = false,
    this.isRequired = false,
    this.isshowHelp = false,
    this.showheading = true,
    this.isFilled = false,
    this.isInValid = false,
    this.isCustomHeight = false,
    this.isForTimeSheet = false,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.onTap,
    this.mainAxisAlignment,
    this.containerColor = Colors.white,
    this.textFieldColor,
    this.isAutoFocus = false,
    this.isWidthForHeader = false,
    this.isNumberOnly = true,
    this.isZeroPadding = false,
    this.containerHeight,
    this.containerWidth,
    this.textStyleOfAll,
    this.fontSizeForAll,
    this.fontSizeForLabel,
    this.isFieldForTable = false,
    this.paddingBelowHeading,
    this.focusNode,
    this.maxLength,
    this.isFIEN = false,
    this.isSUEmpPTAN = false,
  });

  @override
  State<MyTextFieldForSingleLine> createState() => _MyTextFieldForSingleLineState();
}

class _MyTextFieldForSingleLineState extends State<MyTextFieldForSingleLine> {
  @override
  void initState() {
    if (widget.focusNode != null && widget.isForTimeSheet) {
      widget.focusNode?.addListener(() {
        if (!widget.focusNode!.hasFocus) {
          _formatTimeIfNeeded();
        }
      });
    }
    super.initState();
  }

  void _formatTimeIfNeeded() {
    final text = widget.controller!.text.trim();

    // If already in hh:mm format, do nothing
    if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(text)) return;

    // If only number is entered, convert to hh:mm
    if (RegExp(r'^\d{1,2}$').hasMatch(text)) {
      final padded = text.padLeft(2, '0');
      widget.controller!.text = '$padded:00';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showheading)
          Row(
            children: [
              Text(widget.labelText.toString(), style: TextFiledTheme.textStyleHeader(widget.fontSizeForLabel)),
              if (widget.isRequired) Text(" *", style: TextFiledTheme.textStyleHeaderRequired(widget.fontSizeForLabel)),
              if (widget.isshowHelp)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: CustomToolTip(
                    message: widget.helpText ?? "No Content Provided by Cv Generator",
                    verticalOffset: 10,
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
                    child: Icon(Icons.help, size: 15.sp),
                  ),
                ),
            ],
          ),
        if (widget.paddingBelowHeading != null) SizedBox(height: widget.paddingBelowHeading),
        Container(
          decoration: BoxDecoration(
            color: widget.isRed
                ? Colors.red
                : (widget.isEnabled
                      ? widget.containerColor
                      : widget.isForTimeSheet
                      ? widget.containerColor
                      : AppColors.lightBackgroundColor),
            borderRadius: BorderRadius.circular(widget.isFieldForTable ? 0 : Branding.tFborderR),
            border: Border.all(width: widget.isFieldForTable ? 0.5 : 1.w, color: widget.isInValid ? Colors.red : AppColors.borderColor),
          ),
          width: widget.containerWidth,
          height: widget.isCustomHeight ? widget.containerHeight : Branding.tFHeight,
          child: Center(
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              initialValue: widget.intialValue,
              textDirection: TextDirection.ltr,
              autofocus: widget.isAutoFocus,
              cursorColor: Colors.black,
              enabled: widget.isEnabled,
              inputFormatters: (widget.isFIEN ?? false)
                  ? [FeinFormatter()]
                  : (widget.isSUEmpPTAN ?? false)
                  ? [SUEmpPTAN()]
                  : (widget.maxLength != null)
                  ? [
                      LengthLimitingTextInputFormatter(widget.maxLength), // Limits the input length to 3
                      FilteringTextInputFormatter.digitsOnly, // Allows only digits
                    ]
                  : widget.cvvNumber
                  ? [
                      LengthLimitingTextInputFormatter(3), // Limits the input length to 3
                      FilteringTextInputFormatter.digitsOnly, // Allows only digits
                    ]
                  : widget.cardNumber
                  ? [
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      CardNumberInputFormatter(), // Apply the custom formatter
                    ]
                  : widget.cardExpiry
                  ? [
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                      ExpirationDateInputFormatter(),
                    ]
                  : widget.isForTimeSheet
                  ? [TimeTextInputFormatter()]
                  : [],
              style: TextFiledTheme.textStyle(widget.fontSizeForAll).copyWith(color: widget.textFieldColor),
              maxLines: widget.maxLine,
              decoration: TextFiledTheme.inputDecoration(
                prefixIcon: widget.prefixIcon,
                fontSizeForAll: widget.fontSizeForAll,
                isFieldForTable: widget.isFieldForTable,
                isZeroPadding: widget.isZeroPadding,
                hintText: widget.hintText ?? "",
                suffixIcon: widget.suffixIcon,
                // hintTextDirection
              ),
              obscureText: widget.isPassword ? true : false,
              validator: widget.validator as String? Function(String?)?,
              onTap: widget.onTap,
              onSaved: widget.onSaved as void Function(String?)?,
              onChanged: widget.onChange as void Function(String?)?,
              onFieldSubmitted: widget.onFieldSubmitted as void Function(String?)?,
              keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Input Formatter
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int maxLength = 16; // Maximum digits to allow
    String text = newValue.text;

    // If text length exceeds maxLength, retain only maxLength characters
    if (text.length > maxLength) {
      text = text.substring(0, maxLength);
    }

    // Format the text in 1111-1111-1111-1111 pattern
    final StringBuffer newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write('-');
      }
      newText.write(text[i]);
    }

    // Create a new TextEditingValue to apply the formatted text
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpirationDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Ensure the length does not exceed 4
    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    // Insert the slash at the appropriate position
    String formattedText = '';
    if (newText.length > 2) {
      formattedText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    } else {
      formattedText = newText;
    }

    // Validate month
    String month = '';
    if (formattedText.length >= 2) {
      month = formattedText.substring(0, 2);
      int monthValue = int.tryParse(month) ?? 0;
      if (monthValue > 12) {
        month = '12'; // Limit month to 12 if it exceeds
        formattedText = '$month${formattedText.length > 2 ? '/${formattedText.substring(3)}' : ''}';
      }
    }

    // Get the current year (last two digits of the year)
    final currentYear = DateTime.now().year % 100;

    // Validate year
    String year = '';
    if (formattedText.length > 3) {
      year = formattedText.substring(3);
      int? yearValue = int.tryParse(year);

      if (year.length == 2) {
        // Check if year is less than the current year
        if (yearValue != null && yearValue < currentYear) {
          year = currentYear.toString(); // Set year to the current year if it's invalid
          formattedText = '${formattedText.substring(0, 3)}$year';
        }
        if (yearValue == 0) {
          year = '01'; // Avoid "00" in the year field
          formattedText = '${formattedText.substring(0, 3)}$year';
        }
      }
    }

    // Return the new text value with updated cursor position
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class NoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Always return the old value → prevents typing or pasting
    return oldValue;
  }
}

class TimeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    // Remove any non-digit characters
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length >= 3) {
      // Insert colon after 2 digits
      text = '${text.substring(0, 2)}:${text.substring(2, text.length > 4 ? 4 : text.length)}';
    }

    // Limit to max length 5 (HH:MM)
    if (text.length > 5) {
      text = text.substring(0, 5);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class FeinFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // keep only digits
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // limit to max 9 digits (FEIN is 9 digits total)
    if (digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    String newText = '';
    if (digits.length > 2) {
      newText = '${digits.substring(0, 2)}-${digits.substring(2)}';
    } else {
      newText = digits;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class SUEmpPTAN extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit to max 12 digits
    if (digits.length > 12) {
      digits = digits.substring(0, 12);
    }

    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      if (i == 3 || i == 6) {
        buffer.write('-');
      } else if (i == 9) {
        buffer.write('/');
      }
      buffer.write(digits[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
