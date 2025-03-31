import 'package:flutter/material.dart';

import '../theme/app_geometry.dart';

class CPI extends StatelessWidget {
  ///Custom Circular Progress Indicator
  const CPI({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppEdgeInsets.a10,
        child: CircularProgressIndicator(value: value),
      ),
    );
  }
}
