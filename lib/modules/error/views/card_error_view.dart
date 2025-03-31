import 'package:flutter/material.dart';

import '../../../common/theme/app_geometry.dart';
import '../../../common/widgets/custom_text_widget.dart';

class CardErrorView extends StatelessWidget {
  const CardErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: AppEdgeInsets.a10,
      child: Text14W700(message, maxLines: 3, textAlign: TextAlign.center),
    );
  }
}
