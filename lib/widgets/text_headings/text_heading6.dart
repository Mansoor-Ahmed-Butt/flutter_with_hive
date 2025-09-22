import 'package:flutter/widgets.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';


class TextHeading6 extends StatelessWidget {
  const TextHeading6(this.text, {super.key, this.color, this.maxlines, this.textAlign});

  final String text;
  final int? maxlines;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      // overflow: TextOverflow.ellipsis,
      maxLines: maxlines ?? 2,
      softWrap: true,
      style: AppStyle.style12w600(
        color: color,
      ),
    );
  }
}
