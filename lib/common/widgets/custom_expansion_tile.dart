import 'package:flutter/material.dart';

import '../theme/app_geometry.dart';
import 'custom_text_widget.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.leading,
    required this.children,
    this.childrenPadding = AppEdgeInsets.h100,
    this.borderColor,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget? leading;
  final List<Widget> children;
  final EdgeInsetsGeometry childrenPadding;
  final Color? borderColor;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 2,
      borderRadius: AppBorderRadius.a20,
      child: ExpansionTile(
        maintainState: true,
        initiallyExpanded: initiallyExpanded,
        collapsedShape:
            borderColor != null
                ? RoundedRectangleBorder(
                  side: BorderSide(color: borderColor!),
                  borderRadius: AppBorderRadius.a20,
                )
                : null,
        shape:
            borderColor != null
                ? RoundedRectangleBorder(
                  side: BorderSide(color: borderColor!),
                  borderRadius: AppBorderRadius.a20,
                )
                : null,
        childrenPadding: childrenPadding,
        leading: leading,
        title: Text16W500(title),
        children: children,
      ),
    );
  }
}
