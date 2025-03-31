import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_geometry.dart';
import '../theme/app_size.dart';

class CustomLineGradiantContainer extends StatelessWidget {
  const CustomLineGradiantContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.size5,
      height: AppSize.size385,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5.71,
          color: AppColors.transparent, // Transparent color for the border
        ),
        borderRadius: AppBorderRadius.a12, // Optional: Adds rounded corners
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(232, 107, 49, 0), // Transparent color
            Color(0xFFE86B31), // Solid color at 50.38%
            Color.fromRGBO(232, 107, 49, 0), // Transparent color again
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
