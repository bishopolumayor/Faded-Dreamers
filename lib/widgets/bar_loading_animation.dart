import 'dart:async';

import 'package:flutter/material.dart';
import 'package:faded_dreamers/utils/colors.dart';

class BarLoadingAnimation extends StatefulWidget {
  final Color color;
  const BarLoadingAnimation({super.key, this.color = AppColors.mainColor});

  @override
  _BarLoadingAnimationState createState() => _BarLoadingAnimationState();
}

class _BarLoadingAnimationState extends State<BarLoadingAnimation> {
  final int _barCount = 5;
  final List<double> _heights = [20, 30, 40, 30, 20];
  final Duration _animationDuration = const Duration(milliseconds: 500);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animateBars();
  }

  void _animateBars() {
    _timer = Timer.periodic(_animationDuration, (timer) {
      if (mounted) {
        setState(() {
          _heights.add(_heights.removeAt(0));
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_barCount, (index) {
        return AnimatedContainer(
          duration: _animationDuration,
          height: _heights[index],
          width: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
