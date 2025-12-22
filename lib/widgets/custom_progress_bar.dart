import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentPoints;
  final List<int> milestones;
  final Color progressColor;
  final Color trackColor;
  final Widget? completedIcon;
  final Widget? pendingIcon;

  const CustomProgressBar({
    super.key,
    required this.currentPoints,
    required this.milestones,
    this.progressColor = Colors.blue,
    this.trackColor = const Color(0xFFE0E0E0),
    this.completedIcon,
    this.pendingIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (milestones.isEmpty || milestones.length == 1) {
      return const SizedBox.shrink();
    }

    const double iconContainerSize = 24.0;
    final totalSegments = milestones.length - 1;

    int currentMilestoneIndex = 0;
    for (int i = 0; i < milestones.length; i++) {
      if (currentPoints >= milestones[i]) {
        currentMilestoneIndex = i;
      } else {
        break;
      }
    }

    double progressInCurrentSegment = 0.0;

    if (currentMilestoneIndex < totalSegments) {
      final currentMilestone = milestones[currentMilestoneIndex];
      final nextMilestone = milestones[currentMilestoneIndex + 1];
      final segmentLength = nextMilestone - currentMilestone;

      if (segmentLength > 0) {
        final pointsInSegment = currentPoints - currentMilestone;
        progressInCurrentSegment = (pointsInSegment / segmentLength).clamp(
          0.0,
          1.0,
        );
      }
    } else if (currentMilestoneIndex == totalSegments) {
      progressInCurrentSegment = 1.0;
    }

    final totalProgressFraction =
        (currentMilestoneIndex + progressInCurrentSegment) / totalSegments;

    return SizedBox(
      height: 40,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final horizontalPadding = iconContainerSize / 2;

          final progressBarWidth = availableWidth - (horizontalPadding * 2);
          final coloredWidth = progressBarWidth * totalProgressFraction;

          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: horizontalPadding,
                right: horizontalPadding,
                top: 17.5,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: trackColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                left: horizontalPadding,
                right: availableWidth - horizontalPadding - coloredWidth,
                top: 17.5,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(milestones.length, (index) {
                  final isCompleted = currentPoints >= milestones[index];
                  final icon = isCompleted
                      ? (completedIcon ??
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ))
                      : (pendingIcon ??
                            Icon(
                              Icons.circle_outlined,
                              color: trackColor,
                              size: 24,
                            ));

                  return Container(
                    height: iconContainerSize,
                    width: iconContainerSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: icon,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
