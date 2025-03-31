import 'package:flutter/widgets.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_geometry.dart';
import '../theme/app_size.dart';
import 'custom_shimmer_widget.dart';

class CustomCardShimmerWidget extends StatelessWidget {
  const CustomCardShimmerWidget({
    super.key,
    this.height,
    this.borderRadius,
    this.width,
    this.padding,
  });

  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CustomShimmerWidget(
      highLightColor: AppColors.darkColor.withValues(alpha: 0.7),
      baseColor: AppColors.darkColor.withValues(alpha: 0.9),
      child: Container(
        height: height ?? AppSize.size350,
        width: width ?? context.deviceWidth,
        margin: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? AppBorderRadius.a20,
          color: AppColors.white,
        ),
      ),
    );
  }
}
