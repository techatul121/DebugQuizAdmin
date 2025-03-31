import 'package:flutter/material.dart';

import '../../keys/key.dart';

class CustomBottomSheet {
  static void _showBottomSheet({required Widget child}) {
    showModalBottomSheet(
      context: AppKeys.navigatorKey.currentContext!,
      constraints: BoxConstraints(
        maxHeight: AppKeys.navigatorKey.currentContext!.size!.height * 0.95,
      ),
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => child,
    );
  }

  static void show({required Widget child}) {
    _showBottomSheet(child: child);
  }
}
