import 'package:flutter/material.dart';

import '../extensions/size_extensions.dart';

class CustomScreenUtil extends StatelessWidget {
  const CustomScreenUtil({super.key, required this.builder});

  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Sizes.width = size.width;
    Sizes.height = size.height;
    // double width = size.width;
    // double height = size.height;
    //
    // // Height (without SafeArea)
    // final padding = MediaQuery.of(context).viewPadding;
    // double height1 = height - padding.top - padding.bottom;
    //
    // // Height (without status bar)
    // double height2 = height - padding.top;
    //
    // // Height (without status and toolbar)
    // double height3 = height - padding.top - kToolbarHeight;
    //
    // log(
    //   'width ${Sizes.width} height ${Sizes.height}\n'
    //   'height1 $height1 height2 $height2 height3 $height3',
    // );

    if (Sizes.width != 0 && Sizes.height != 0) {
      /// Close to dialog if any diaog open

      debugPrint(
        'CustomScreenUtil: Width: ${Sizes.width} Height: ${Sizes.height}',
      );
      return Builder(builder: builder);
    } else {
      // debugPrint('CustomScreenUtil: Width and Height are 0');
      return Container();
    }
  }
}
