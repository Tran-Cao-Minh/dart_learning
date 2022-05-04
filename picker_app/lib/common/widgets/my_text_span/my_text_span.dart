import 'package:flutter/material.dart';
import 'mark_text_styles.dart';

extension SpanLabelTheme on ThemeData {
  TextStyle get spanLabelDefaultStyle => primaryTextTheme.bodyText1!;

  TextStyle get spanLabelBoldStyle => primaryTextTheme.bodyText1!;

  TextStyle get spanLabelItalicStyle => primaryTextTheme.bodyText1!;

  TextStyle get spanLabelBoldItalicStyle => primaryTextTheme.bodyText1!;
}

class Tag {
  static const String startBold = '{b}';
  static const String endBold = '{/b}';

  static const String startItalic = '{i}';
  static const String endItalic = '{/i}';

  static const String startBoldItalic = '{bi}';
  static const String endBoldItalic = '{/bi}';
}

class MyTextSpan extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  final TextStyle? defaultStyle;
  final TextStyle? boldStyle;
  final TextStyle? italicStyle;
  final TextStyle? boldItalicStyle;
  final TextOverflow? overflow;
  final int? maxLines;

  MyTextSpan({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.defaultStyle,
    this.boldStyle,
    this.italicStyle,
    this.boldItalicStyle,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      text: TextSpan(
        style: defaultStyle ?? Theme.of(context).spanLabelDefaultStyle,
        children: AppTextSpan.buildTextSpans(
          text,
          <AppTextSpan>[
            AppTextSpan(
              Tag.startBold,
              Tag.endBold,
              boldStyle ?? Theme.of(context).spanLabelBoldStyle,
            ),
            AppTextSpan(
              Tag.startItalic,
              Tag.endItalic,
              italicStyle ?? Theme.of(context).spanLabelItalicStyle,
            ),
            AppTextSpan(
              Tag.startBoldItalic,
              Tag.endBoldItalic,
              boldItalicStyle ?? Theme.of(context).spanLabelBoldItalicStyle,
            ),
          ],
        ),
      ),
    );
  }
}
