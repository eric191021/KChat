import 'dart:io';

import 'package:flutter/material.dart';

class WaterMarkBgView extends StatelessWidget {
  final String? path;
  final String text;
  final TextStyle textStyle;
  final Widget child;

  const WaterMarkBgView({
    Key? key,
    this.path,
    this.text = '',
    this.textStyle = const TextStyle(
      color: Color(0xFFE3E3E3),
      fontSize: 24,
      decoration: TextDecoration.none,
    ),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          if (path?.isNotEmpty == true)
            Image.file(
              File(path!),
              fit: BoxFit.cover,
            ),
          if (text.isNotEmpty) _buildWaterMarkTextView(context: context),
          child,
        ],
      ),
    );
  }

  Widget _buildWaterMarkTextView({required BuildContext context}) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    var size = _textSize(text, textStyle);
    double itemW = size.width;
    double itemH = size.height;

    int rowCount = (screenW / itemW).round() + 1;
    int columnCount = (screenH / itemH).round() + 1;

    double maxW = screenW * 1.5;
    double maxH = screenH * 1.5;

    List<Widget> children = List.filled(
      columnCount * rowCount,
      Container(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.skewY(-0.3),
          child: Center(
            child: Text(
              text,
              style: textStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
    return OverflowBox(
      maxWidth: maxW,
      maxHeight: maxH,
      alignment: Alignment.centerLeft,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: rowCount,
        ),
        physics: NeverScrollableScrollPhysics(),
        children: children,
      ),
    );
  }

  // Here it is!
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
