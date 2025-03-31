import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/app_size.dart';

class CustomResponsiveCenterScrollableWidget extends StatelessWidget {
  const CustomResponsiveCenterScrollableWidget({
    super.key,
    this.maxContentWidth,
    this.padding = EdgeInsets.zero,
    this.controller,
    required this.child,
  });

  final double? maxContentWidth;
  final EdgeInsetsGeometry padding;
  final ScrollController? controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        final c = controller;
        if (pointerSignal is PointerScrollEvent && c != null) {
          final newOffset = c.offset + pointerSignal.scrollDelta.dy;
          if (newOffset < c.position.minScrollExtent) {
            c.jumpTo(c.position.minScrollExtent);
          } else if (newOffset > c.position.maxScrollExtent) {
            c.jumpTo(c.position.maxScrollExtent);
          } else {
            c.jumpTo(newOffset);
          }
        }
      },
      child: Scrollbar(
        controller: controller,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxContentWidth ?? AppSize.size750,
            ),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
