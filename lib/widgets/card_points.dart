import 'package:flutter/material.dart';
import 'custom_progress_bar.dart';

/// A milestone-based progress bar widget.
///
/// Displays progress with animated milestones, supports custom icons,
/// labels, and interaction callbacks.
class CardPoints extends StatelessWidget {
  /// The current progress value.
  final int currentPoints;

  /// The milestone values list.
  final List<int> milestones;

  /// Optional labels under each milestone.
  final List<String>? labels;

  /// Color of the completed progress line.
  final Color progressColor;

  /// Color of the remaining track line.
  final Color? trackColor;

  /// Widget displayed for completed milestones.
  final Widget? completedIcon;

  /// Widget displayed for pending milestones.
  final Widget? pendingIcon;

  /// Size of milestone icons.
  final double iconSize;

  /// Height/thickness of the connecting lines.
  final double? lineHeight;

  /// Animation duration for the progress line.
  final Duration? animationDuration;

  /// Animation curve for the progress line.
  final Curve? animationCurve;

  /// TextStyle for milestone labels.
  final TextStyle? labelStyle;

  /// Callback when a milestone is tapped.
  final Function(int index)? onMilestoneTap;

  /// Creates a [CardPoints] widget.
  ///
  /// [currentPoints] determines the current progress.
  /// [milestones] is the list of milestone values.
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
    this.lineHeight,
    this.animationDuration,
    this.animationCurve,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomProgressBar(
      lineHeight: lineHeight ?? 6.0,
      animationDuration: animationDuration ?? const Duration(milliseconds: 500),
      animationCurve: animationCurve ?? Curves.easeInOut,
      labelStyle: labelStyle,
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
