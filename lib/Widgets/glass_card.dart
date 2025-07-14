import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const GlassCard({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: isDark
          ? ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      )
          : Center(child: child),
    );
  }
}
