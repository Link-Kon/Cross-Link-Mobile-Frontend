import 'package:flutter/material.dart';

class BorderWidget extends StatelessWidget {
  const BorderWidget({
    super.key,
    required this.child,
    this.radius = 8,
  });

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade200
        )
      ),
      child: child
    );
  }
}
