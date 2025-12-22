import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_progress_bar.dart';

class CardPoints extends StatelessWidget {
  final int currentPoints;
  final List<int> milestones;
  final List<String>? labels;
  final Color progressColor;
  final Color? trackColor;
  final Widget? completedIcon;
  final Widget? pendingIcon;
  final double iconSize;

  const CardPoints({
    super.key,
    required this.currentPoints,
    this.milestones = const [0, 10, 20, 30, 40],
    this.labels,
    this.progressColor = Colors.blue,
    this.trackColor,
    this.completedIcon,
    this.pendingIcon,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomProgressBar(
      iconSize: iconSize,
      completedIcon: completedIcon ?? 
          SvgPicture.asset("assets/images/check.svg", width: iconSize),
      pendingIcon: pendingIcon ?? 
          SvgPicture.asset("assets/images/empty_check.svg", width: iconSize),
      currentPoints: currentPoints,
      trackColor: trackColor ?? const Color(0xFFE0E0E0),
      milestones: milestones,
      labels: labels,
      progressColor: progressColor,
    );
  }
}