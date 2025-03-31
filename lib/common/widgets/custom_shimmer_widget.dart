import 'package:flutter/material.dart';

class CustomShimmerWidget extends StatefulWidget {
  final Widget child;

  const CustomShimmerWidget({
    super.key,
    required this.child,
    this.baseColor,
    this.highLightColor,
  });

  final Color? baseColor;
  final Color? highLightColor;

  @override
  CustomShimmerState createState() => CustomShimmerState();
}

class CustomShimmerState extends State<CustomShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController.unbounded(vsync: this);

    _shimmerAnimation =
        _controller
          ..repeat(min: -0.5, max: 1.5, period: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LinearGradient _shimmerGradient(double shimmerPosition) {
    return LinearGradient(
      colors: [
        widget.baseColor ?? Colors.grey.shade300, // Base grey color
        widget.highLightColor ??
            Colors.grey.shade100, // Lighter color for the shining effect

        widget.baseColor ?? Colors.grey.shade300, // Base grey color again
      ],
      stops: [0.1, 0.3, 0.4],
      begin: Alignment(-1.0 + shimmerPosition, -0.3),
      end: Alignment(1.0 + shimmerPosition, 0.3),
      tileMode: TileMode.clamp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return _shimmerGradient(
              _shimmerAnimation.value,
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
