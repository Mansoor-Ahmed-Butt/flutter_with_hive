import 'package:flutter/widgets.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';

class TextHeading3 extends StatelessWidget {
  const TextHeading3(this.text, {super.key, this.color, this.textAlign});

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: AppStyle.style20w600(color: color),
    );
  }
}
