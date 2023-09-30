import 'package:flutter/material.dart';

class SectionTextWidget extends StatelessWidget {
  const SectionTextWidget({
    super.key,
    required this.text,
    this.bold = false,
  });

  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: const Color.fromRGBO(143,143,143,1),
        fontSize: 16.0,
        fontWeight: bold? FontWeight.w600 : null
      ),
    );
  }
}