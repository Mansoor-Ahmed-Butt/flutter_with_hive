import 'package:flutter/widgets.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';

class TextHeading4 extends StatelessWidget {
  const TextHeading4(this.text, {super.key, this.color, this.textAlign, this.styleLabel});

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? styleLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: styleLabel ?? AppStyle.style16w600(color: color),
    );
  }
}
