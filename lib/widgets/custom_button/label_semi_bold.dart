import 'package:flutter/widgets.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';

// import 'package:gcountyusa/theme/text_style.dart';
class LabelSemiBold extends StatelessWidget {
  const LabelSemiBold(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.isUnderLine = false,
    this.maxLines,
    this.isSmall = false,
    this.isDontAddOverFlow,
    this.style,
    this.fontFamily,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool isUnderLine;
  final bool isSmall;
  final bool? isDontAddOverFlow;
  final TextStyle? style;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: (isDontAddOverFlow == true) ? null : TextOverflow.ellipsis,
      style:
          style ??
          (isSmall
              ? AppStyle.style10w600(color: color, fontFamily: fontFamily ?? "Montserrat")
              : AppStyle.style12w600(color: color, isUnderLine: isUnderLine, fontFamily: fontFamily ?? "Montserrat")),
    );
  }
}
