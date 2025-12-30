import 'package:flutter/material.dart';

/// Internal widget that draws the progress bar and milestone icons.
class CustomProgressBar extends StatelessWidget {
  /// The current progress value.
  final int currentPoints;

  /// The milestone values list.
  final List<int> milestones;

  /// Optional labels under each milestone.
  final List<String>? labels;

  /// Color of the completed progress line.
  final Color progressColor;

  /// Color of the remaining track line.
  final Color trackColor;

  /// Widget displayed for completed milestones.
  final Widget? completedIcon;

  /// Widget displayed for pending milestones.
  final Widget? pendingIcon;

  /// Size of milestone icons.
  final double iconSize;

  /// Height/thickness of the connecting lines.
  final double lineHeight;

  /// Animation duration for the progress line.
  final Duration animationDuration;

  /// Animation curve for the progress line.
  final Curve animationCurve;

  /// TextStyle for milestone labels.
  final TextStyle? labelStyle;

  /// Callback when a milestone is tapped.
  final Function(int index)? onMilestoneTap;

  /// Creates a [CustomProgressBar] widget.
  ///
  /// [milestones] must have at least 2 values.
  /// [labels] length must match [milestones] if provided.
  const CustomProgressBar({
    super.key,
    required this.currentPoints,
    required this.milestones,
    this.labels,
    this.progressColor = Colors.blue,
    this.trackColor = const Color(0xFFE0E0E0),
    this.completedIcon,
    this.pendingIcon,
    this.iconSize = 24.0,
    this.lineHeight = 6.0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.labelStyle,
    this.onMilestoneTap,
  }) : assert(labels == null || labels.length == milestones.length,
            'Labels length must match milestones length');

  double _calculateSegmentProgress(int start, int end) {
    if (currentPoints >= end) return 1.0;
    if (currentPoints <= start) return 0.0;
    return (currentPoints - start) / (end - start);
  }

  @override
  Widget build(BuildContext context) {
    if (milestones.isEmpty || milestones.length <= 1) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            milestones.length + (milestones.length - 1),
            (index) {
              if (index % 2 == 0) {
                final milestoneIndex = index ~/ 2;
                final isCompleted = currentPoints >= milestones[milestoneIndex];

                return GestureDetector(
                  onTap: () {
                    if (onMilestoneTap != null) {
                      onMilestoneTap!(milestoneIndex);
                    }
                  },
                  child: _buildIcon(isCompleted),
                );
              } else {
                final segmentIndex = index ~/ 2;
                final progress = _calculateSegmentProgress(
                  milestones[segmentIndex],
                  milestones[segmentIndex + 1],
                );
                return _buildLineSegment(progress);
              }
            },
          ),
        ),
        if (labels != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels!.asMap().entries.map((entry) {
              final index = entry.key;
              final label = entry.value;
              return GestureDetector(
                onTap: () => onMilestoneTap?.call(index),
                child: SizedBox(
                  width: iconSize,
                  height: 30,
                  child: OverflowBox(
                    maxWidth: iconSize * 3,
                    maxHeight: 30,
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: labelStyle ??
                            const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                        softWrap: false,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  /// Builds the milestone icon.
  Widget _buildIcon(bool isCompleted) {
    return Container(
      width: iconSize,
      height: iconSize,
      alignment: Alignment.center,
      child: isCompleted
          ? (completedIcon ??
              Icon(Icons.check_circle, color: Colors.green, size: iconSize))
          : (pendingIcon ??
              Icon(Icons.circle_outlined, color: trackColor, size: iconSize)),
    );
  }

  /// Builds a line segment between two milestones.
  Widget _buildLineSegment(double progress) {
    return Expanded(
      child: SizedBox(
        height: lineHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: lineHeight,
              decoration: BoxDecoration(
                color: trackColor,
                borderRadius: BorderRadius.circular(lineHeight),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: animationDuration,
                    curve: animationCurve,
                    height: lineHeight,
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(lineHeight),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
