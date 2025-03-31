import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_size.dart';
import '../custom_text_widget.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.onTap,
    this.height,
    this.width,
    required this.text,
    this.child,
    this.color,
    this.borderRadius,
  });

  final GestureTapCallback? onTap;
  final double? height;
  final double? width;
  final String text;
  final Widget? child;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppSize.size50,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor:
              color != null ? WidgetStateProperty.all<Color>(color!) : null,
          elevation: WidgetStateProperty.all<double>(2),
          shadowColor: WidgetStateProperty.all<Color>(AppColors.black),
          shape:
              borderRadius != null
                  ? WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: borderRadius!),
                  )
                  : null,
        ),
        child:
            child ??
            Text16W500(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: AppColors.white,
            ),
      ),
    );
  }
}
