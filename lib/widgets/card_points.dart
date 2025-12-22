import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reward_progress_bar/widgets/custom_progress_bar.dart';

class CardPoints extends StatelessWidget {
  final int currentPoints;
  final List<int> milestones;
  final Color progressColor;
  final Color trackColor;
  final Widget? completedIcon;
  final Widget? pendingIcon;
  const CardPoints({
    super.key,
    required this.currentPoints,
    this.milestones = const [0, 10, 20, 30, 40],
    this.progressColor = Colors.blue,
    required this.trackColor,
    this.completedIcon,
    this.pendingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomProgressBar(
      completedIcon:
          completedIcon ?? SvgPicture.asset("assets/images/check.svg"),
      pendingIcon:
          pendingIcon ?? SvgPicture.asset("assets/images/empty_check.svg"),
      currentPoints: currentPoints,
      trackColor: trackColor,
      milestones: milestones,
      progressColor: progressColor,
    );
  }
}
