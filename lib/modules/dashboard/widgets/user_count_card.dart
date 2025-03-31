import 'package:flutter/material.dart';

import '../../../common/theme/app_geometry.dart';
import '../../../common/theme/app_size.dart';
import '../../../common/widgets/custom_card.dart';
import '../../../common/widgets/custom_text_widget.dart';
import 'custom_title.dart';

class UserCountCard extends StatelessWidget {
  final String title;
  final String count;
  final String assetName;

  const UserCountCard({
    super.key,
    required this.title,
    required this.count,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            top: -54,
            right: -63,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.teal.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.3),
                    Colors.teal.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.3),
                    Colors.teal.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.3),
                    Colors.teal.withValues(alpha: 0.4),
                    Colors.white,
                  ],
                  stops: [0.01, 0.15, 0.30, 0.45, 0.60, 0.75, 0.90, 1.0],
                  radius: 0.52,
                  center: Alignment.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: AppEdgeInsets.a10,
            child: Column(
              spacing: AppSize.size45,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitle(assetName: assetName, title: title),
                Text36W400(count),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
