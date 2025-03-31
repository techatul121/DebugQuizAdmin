import 'package:flutter/material.dart';

import '../../../common/widgets/custom_responsive_builder.dart';
import '../../coming_soon/coming_soon_view.dart';
import '../widgets/desktop/base_desktop_view.dart';

class BaseView extends StatelessWidget {
  final Widget child;

  const BaseView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      desktop: BaseDesktopView(child: child),
      mobile: const ComingSoonView(),
      tablet: const ComingSoonView(),
    );
  }
}
