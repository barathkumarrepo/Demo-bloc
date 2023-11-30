import 'package:flutter/material.dart';

import 'fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final Font font;
  final Color color;
  final double lineHeight;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final isUnderLine;
  final isSingleLine;
  final int? maxLines;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;

  CustomText(String? text,
      {this.fontWeight,
      this.fontStyle,
      this.fontSize = 14,
      this.font = Font.LatoBlack,
      this.color = Colors.black,
      this.lineHeight = 1.21, // Line Height - 17
      this.textAlign = TextAlign.left,
      this.onTap,
      this.isUnderLine = false,
      this.isSingleLine = false,
      this.maxLines, this.overflow})
      : this.text = text;

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(this.text ?? "",
        textAlign: this.textAlign,
        overflow: isSingleLine ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
        style: TextStyle(
            decoration:
                isUnderLine ? TextDecoration.underline : TextDecoration.none,
            color: color,
            fontFamily: font.value,
            fontSize: fontSize,
            overflow: overflow,
            height: lineHeight));

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
