import 'package:doculode/app/config/index.dart';













 

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart'; 

enum StepStatus { completed, inProgress, pending }

class StepData {
  final String title;
  final StepStatus status;
  final IconData? completedIcon; 
  final IconData?
      inProgressIcon; 
  final IconData? pendingIcon; 

  StepData({
    required this.title,
    required this.status,
    this.completedIcon = Ionicons.checkmark_circle,
    this.inProgressIcon, 
    this.pendingIcon = Ionicons.ellipse_outline, 
  });
}

class StepperIndicator extends StatelessWidget {
  final List<StepData> steps;
  final Color activeColor; 
  final Color inactiveColor; 
  final Color completedTextColor;
  final Color inProgressTextColor;
  final Color pendingTextColor;
  final double iconSize;

  const StepperIndicator({
    super.key,
    required this.steps,
    required this.activeColor,
    required this.inactiveColor,
    required this.completedTextColor,
    required this.inProgressTextColor,
    required this.pendingTextColor,
    this.iconSize = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> stepWidgets = [];

    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      IconData displayIcon;
      Color iconColor;
      Color titleColor;
      bool completed = false;
      FontWeight titleFontWeight = FontWeight.normal;

      switch (step.status) {
        case StepStatus.completed:
          displayIcon =
              step.completedIcon ?? Ionicons.checkmark_done_circle_outline;

          iconColor = activeColor;
          titleColor = completedTextColor;
          completed = true;
          titleFontWeight = FontWeight.bold;
          break;
        case StepStatus.inProgress:
          displayIcon =
              step.inProgressIcon ?? Ionicons.lock_closed_outline; 
          iconColor = inProgressTextColor;
          titleColor = theme.colorScheme.onSurface;
          
          titleFontWeight = FontWeight.bold;
          break;
        case StepStatus.pending:
          displayIcon =
              step.pendingIcon ?? Ionicons.ellipsis_horizontal_circle_outline;
          iconColor = inactiveColor;
          titleColor = pendingTextColor;
          
          break;
      }

      stepWidgets.add(
        Flexible(
          
          child: Container(
            padding: Insets.iconButton,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: Corners.smBorder,
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(displayIcon, size: iconSize, color: iconColor),
                HSpace.sm,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "STEP ${i + 1}",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: titleColor.withValues(alpha: 0.7),
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      step.title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        
                        color: titleColor,
                        fontWeight: titleFontWeight,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Spacer(),
                if (completed) ...[
                  Icon(Icons.check_circle,
                      size: IconSizes.med, color: AppTheme.successColor),
                ],
              ],
            ),
          ),
        ),
      );

      if (i < steps.length - 1) {
        stepWidgets.add(VSpace.lg);
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: stepWidgets,
    );
  }
}
