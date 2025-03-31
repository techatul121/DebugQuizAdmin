import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_geometry.dart';
import '../../theme/app_size.dart';
import '../custom_circular_progress_indicator.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final GestureTapCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? AppBorderRadius.a5;
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        // child: CachedNetworkImage(
        //   fit: fit,
        //   height: height,
        //   width: width,
        //   imageUrl: imageUrl,
        //   placeholder: (context, url) {
        //     return const CustomNetworkImagePlaceholder();
        //   },
        //   errorWidget: (context, url, error) {
        //     return Container(
        //       color: AppColors.lightGrey,
        //       child: Icon(
        //         Icons.broken_image_rounded,
        //         size: AppSize.size50,
        //         color: AppColors.grey,
        //       ),
        //     );
        //   },
        // ),
        child: Image.network(
          imageUrl,
          fit: fit,
          height: height,
          width: width,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const CPI();
          },
          errorBuilder: (context, url, error) {
            return Container(
              color: AppColors.lightGrey,
              child: Icon(
                Icons.broken_image_rounded,
                size: AppSize.size50,
                color: AppColors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
