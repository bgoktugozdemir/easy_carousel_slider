import 'dart:async';

import 'package:flutter/material.dart';

import 'models/models.dart';
import 'widgets/widgets.dart';

class CarouselSlider extends StatefulWidget {
  CarouselSlider({
    super.key,
    required this.items,
    this.viewportFraction = 0.8,
    BorderRadiusGeometry? borderRadius,
    this.indicatorOptions,
    this.scrollPhysics,
    this.autoSliderDuration,
    this.autoSliderAnimationDuration,
  })  : borderRadius = borderRadius ?? BorderRadius.circular(8),
        assert(viewportFraction > 0);

  final List<Widget> items;
  final double viewportFraction;
  final BorderRadiusGeometry borderRadius;
  final IndicatorOptions? indicatorOptions;
  final ScrollPhysics? scrollPhysics;
  final Duration? autoSliderDuration;
  final Duration? autoSliderAnimationDuration;
  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late final PageController controller;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: widget.viewportFraction);
    setTimer();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: controller,
          pageSnapping: true,
          itemCount: itemCount,
          physics: widget.scrollPhysics,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            return AnimatedBuilder(
              animation: controller,
              builder: (context, child) => child!,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: widget.borderRadius,
                ),
                child: item,
              ),
            );
          },
        ),
        if (widget.indicatorOptions != null)
          Positioned(
            left: widget.indicatorOptions!.position.left,
            bottom: widget.indicatorOptions!.position.bottom,
            top: widget.indicatorOptions!.position.top,
            right: widget.indicatorOptions!.position.right,
            child: DotsIndicator(
              pageController: controller,
              itemCount: itemCount,
              indicatorOptions: widget.indicatorOptions!,
            ),
          ),
      ],
    );
  }

  int get itemCount => widget.items.length;

  void setTimer() {
    timer?.cancel();
    if (widget.autoSliderDuration != null) {
      timer = Timer.periodic(
        widget.autoSliderDuration!,
        (_) => toNextPage(),
      );
    }
  }

  Future<void> toNextPage() async {
    if (controller.page == null) {
      return;
    }
    final duration =
        widget.autoSliderAnimationDuration ?? const Duration(seconds: 1);

    if (controller.page! >= widget.items.length - 1) {
      return controller.animateToPage(
        0,
        duration: duration,
        curve: Curves.easeOutSine,
      );
    } else {
      return controller.nextPage(
        duration: duration,
        curve: Curves.easeInQuart,
      );
    }
  }
}
