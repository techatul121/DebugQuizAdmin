import 'package:flutter/widgets.dart';

import 'custom_card_shimmer_widget.dart';
import 'custom_sized_box.dart';

class CustomShimmerListView extends StatelessWidget {
  const CustomShimmerListView({
    super.key,
    this.itemHeight,
    this.itemWidth,
    this.scrollDirection = Axis.horizontal,
    this.itemBorderRadius,
    this.padding,
    this.itemCount = 4,
  });

  final double? itemHeight;
  final double? itemWidth;
  final Axis scrollDirection;
  final int itemCount;
  final BorderRadiusGeometry? itemBorderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? EdgeInsets.zero,
      separatorBuilder:
          (context, index) =>
              scrollDirection == Axis.horizontal
                  ? const SBW10()
                  : const SBH10(),
      itemCount: itemCount,
      scrollDirection: scrollDirection,
      itemBuilder:
          (context, index) => CustomCardShimmerWidget(
            width: itemWidth,
            height: itemHeight,
            borderRadius: itemBorderRadius,
          ),
    );
  }
}
