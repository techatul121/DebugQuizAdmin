import 'package:flutter/material.dart';

import '../../../../common/theme/app_geometry.dart';
import '../custom_side_bar.dart';

class BaseDesktopView extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;

  const BaseDesktopView({
    super.key,
    required this.child,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Row(
        children: [
          const Expanded(flex: 2, child: CustomSideBar()),
          Expanded(
            flex: 10,
            child: Padding(padding: AppEdgeInsets.a20, child: child),
          ),
        ],
      ),
    );
  }
}
