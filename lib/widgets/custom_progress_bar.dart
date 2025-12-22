import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentPoints;
  final List<int> milestones;
  final List<String>? labels;
  final Color progressColor;
  final Color trackColor;
  final Widget? completedIcon;
  final Widget? pendingIcon;
  final double iconSize;
  final double lineHeight;
  final Duration animationDuration;
  final Curve animationCurve;
  final TextStyle? labelStyle;

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
                return _buildIcon(isCompleted);
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
            children: labels!.map((label) => SizedBox(
                  width: iconSize,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: labelStyle ??
                        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildIcon(bool isCompleted) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: isCompleted
          ? (completedIcon ??
              Icon(Icons.check_circle, color: Colors.green, size: iconSize))
          : (pendingIcon ??
              Icon(Icons.circle_outlined, color: trackColor, size: iconSize)),
    );
  }

  Widget _buildLineSegment(double progress) {
    return Expanded(
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
    );
  }
}