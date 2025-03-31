import 'package:flutter/widgets.dart';

import '../../common/theme/app_colors.dart';
import '../../common/theme/app_geometry.dart';
import '../../common/widgets/custom_text_widget.dart';

class CustomCellWidget extends StatelessWidget {
  const CustomCellWidget({
    super.key,
    required this.cellValue,
    this.color,
    this.alignment,
  });

  final dynamic cellValue;
  final Color? color;
  final Alignment? alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          alignment ??
          (cellValue is int ? Alignment.center : Alignment.centerLeft),
      child: Padding(
        padding: AppEdgeInsets.h10,
        child: Text16W500(cellValue.toString(), color: color ?? AppColors.blue),
      ),
    );
  }
}
