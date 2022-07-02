import 'package:flutter/material.dart';

import 'models.dart';

@immutable
class IndicatorOptions {
  const IndicatorOptions({
    this.onTap,
    this.dotSize = 8,
    this.activeDotSize = 8,
    this.dotColor = Colors.grey,
    this.activeDotColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.axis = Axis.horizontal,
    this.spacing = 4,
    this.opacity = 0.8,
    this.position = const IndicatorPosition(),
  }) : assert(opacity >= 0 && opacity <= 1);

  final VoidCallback? onTap;
  final double dotSize;
  final double activeDotSize;
  final Color dotColor;
  final Color? activeDotColor;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Axis axis;
  final double spacing;
  final double opacity;
  final IndicatorPosition position;
}
