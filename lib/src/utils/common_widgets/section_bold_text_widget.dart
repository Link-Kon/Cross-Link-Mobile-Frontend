import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class SectionBoldTextWidget extends StatelessWidget {
  const SectionBoldTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: Palette.black, fontSize: 20.0, fontWeight: FontWeight.w500),);
  }
}