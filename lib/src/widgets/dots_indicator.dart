import 'dart:math';

import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class DotsIndicator extends StatefulWidget {
  const DotsIndicator({
    super.key,
    required this.indicatorOptions,
    required this.pageController,
    required this.itemCount,
  });

  final IndicatorOptions indicatorOptions;
  final PageController pageController;
  final int itemCount;

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  late double position;

  @override
  void initState() {
    super.initState();
    position = 0;
    widget.pageController.addListener(updatePosition);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(updatePosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indicatorOptions.axis == Axis.vertical) {
      return Column(
        mainAxisAlignment: widget.indicatorOptions.mainAxisAlignment,
        mainAxisSize: widget.indicatorOptions.mainAxisSize,
        children: dots,
      );
    }

    return Row(
      mainAxisAlignment: widget.indicatorOptions.mainAxisAlignment,
      mainAxisSize: widget.indicatorOptions.mainAxisSize,
      children: dots,
    );
  }

  List<Widget> get dots {
    return List<Widget>.generate(
      widget.itemCount,
      (index) {
        final lerp = min(1.0, (position - index).abs());
        return Dots(
          onTap: widget.indicatorOptions.onTap,
          index: index,
          size: Size.lerp(
            Size.square(widget.indicatorOptions.activeDotSize),
            Size.square(widget.indicatorOptions.dotSize),
            lerp,
          )!,
          color: Color.lerp(
            widget.indicatorOptions.activeDotColor ??
                Theme.of(context).primaryColor,
            widget.indicatorOptions.dotColor,
            lerp,
          )?.withOpacity(widget.indicatorOptions.opacity),
          spacing: widget.indicatorOptions.spacing,
        );
      },
    );
  }

  void updatePosition() {
    setState(() {
      position = widget.pageController.page ?? 0;
    });
  }
}
