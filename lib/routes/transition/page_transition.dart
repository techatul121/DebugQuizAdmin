import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageTransition extends CustomTransitionPage {
  PageTransition({required super.child, super.key})
    : super(
        transitionDuration: Durations.medium3,
        reverseTransitionDuration: Durations.medium3,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );
}
