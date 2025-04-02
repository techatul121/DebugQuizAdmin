import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color hoverColor;
  final Color activeColor;
  final Color inactiveColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.hoverColor = Colors.transparent,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
  });

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: isHovered ? widget.hoverColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(4),
        child: Switch(
          value: widget.value,
          onChanged: widget.onChanged,
          activeColor: widget.activeColor,
          inactiveThumbColor: widget.inactiveColor,
          inactiveTrackColor: widget.inactiveColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
