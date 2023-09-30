import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class MenuTileWidget extends StatefulWidget {
  const MenuTileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  State<MenuTileWidget> createState() => _MenuTileWidgetState();
}

class _MenuTileWidgetState extends State<MenuTileWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {setState(() {_isPressed = true;});},
      onTapCancel: () {setState(() {_isPressed = false;});},
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 30),
        onTap: widget.onPress,
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(widget.icon),
        ),
        title: Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        trailing: widget.endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: const Icon(Icons.arrow_forward, size: 18, color: Colors.grey,),
        ) : null,
        textColor: _isPressed? Palette.textSelected : Palette.blackOpacity,
        iconColor: _isPressed? Palette.textSelected : Palette.blackOpacity,
        selectedColor: Colors.red,
      ),
    );
  }
}