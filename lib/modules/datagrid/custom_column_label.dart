import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';
import '../../../common/theme/app_geometry.dart';
import '../../../common/widgets/custom_text_widget.dart';

class CustomColumnLabel extends StatelessWidget {
  const CustomColumnLabel({
    super.key,
    required this.title,
    this.padding,
    this.alignment,
  });

  final String title;
  final EdgeInsets? padding;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: _LabelWidget(padding: padding, title: title),
        )
        : Padding(
          padding: padding ?? AppEdgeInsets.h10,
          child: Text16W500(title, color: AppColors.white),
        );
  }
}

class _LabelWidget extends StatelessWidget {
  const _LabelWidget({super.key, required this.padding, required this.title});

  final EdgeInsets? padding;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppEdgeInsets.h10,
      child: Text16W500(title, color: AppColors.white),
    );
  }
}
