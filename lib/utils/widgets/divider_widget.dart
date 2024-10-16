import 'package:flutter/material.dart';
import 'package:qrypt/base/theme/app_theme.dart';

class DividerWidget extends StatelessWidget {
  final double verticalMargin;
  final Color? color;

  const DividerWidget({super.key, required this.verticalMargin, this.color });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: color ?? themeOf().dividerColor,
      margin: EdgeInsets.symmetric(vertical:verticalMargin),
    );
  }
}
