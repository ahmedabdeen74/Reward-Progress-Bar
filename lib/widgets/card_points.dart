import 'package:flutter/material.dart';
import 'package:reward_progress_bar/reward_progress_bar.dart';

class CardPoints extends StatelessWidget {
  final int currentPoints;
  final List<int> milestones;
  final List<String>? labels;
  final Color progressColor;
  final Color? trackColor;
  final Widget? completedIcon;
  final Widget? pendingIcon;
  final double iconSize;
  final Function(int index)? onMilestoneTap;

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
    this.onMilestoneTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomProgressBar(
      onMilestoneTap: onMilestoneTap,
      iconSize: iconSize,
      completedIcon: completedIcon ??
          Icon(Icons.check_circle, color: Colors.green, size: iconSize),
      pendingIcon: pendingIcon ??
          Icon(Icons.circle_outlined,
              color: trackColor ?? const Color(0xFFE0E0E0), size: iconSize),
      currentPoints: currentPoints,
      trackColor: trackColor ?? const Color(0xFFE0E0E0),
      milestones: milestones,
      labels: labels,
      progressColor: progressColor,
    );
  }
}
