import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class SectionTitleTextWidget extends StatelessWidget {
  const SectionTitleTextWidget({
    super.key,
    required this.text,
    this.size = 28.0,
  });

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Palette.black, fontSize: size, fontWeight: FontWeight.w600),);
  }
}