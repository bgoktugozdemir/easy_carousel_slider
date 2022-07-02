import 'package:flutter/foundation.dart';

@immutable
class IndicatorPosition {
  final double? left;
  final double? top;
  final double? bottom;
  final double? right;

  const IndicatorPosition({
    this.left = 0,
    this.top,
    this.bottom = 8,
    this.right = 0,
  });

  const IndicatorPosition.fromLTBR(
    this.left,
    this.top,
    this.bottom,
    this.right,
  );

  static const IndicatorPosition zero = IndicatorPosition.fromLTBR(0, 0, 0, 0);
}
