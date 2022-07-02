import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  const Dots({
    super.key,
    required this.index,
    this.size = const Size.square(8),
    this.spacing = 4,
    this.onTap,
    this.color,
  });

  final int index;
  final Size size;
  final double spacing;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height,
        margin: EdgeInsets.all(spacing),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
