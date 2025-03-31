import 'package:flutter/material.dart';

class CustomSeparatedBouncingList extends StatelessWidget {
  const CustomSeparatedBouncingList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.controller,
    this.padding,
  });

  final int itemCount;
  final Widget Function(BuildContext, int) separatorBuilder;
  final Widget? Function(BuildContext, int) itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: padding,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: itemCount,
      separatorBuilder: separatorBuilder,
      itemBuilder: itemBuilder,
    );
  }
}
