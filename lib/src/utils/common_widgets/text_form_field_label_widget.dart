import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldLabelWidget extends StatelessWidget {
  const TextFormFieldLabelWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.enable = true,
    this.textLength = 100,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool enable;
  final int textLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabled: enable,
        label: Text(label),
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide(color: Colors.grey.shade300)
        )
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(textLength),
      ],
      validator: validator,
    );
  }
}