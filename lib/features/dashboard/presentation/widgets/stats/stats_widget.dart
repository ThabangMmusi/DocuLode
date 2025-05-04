import 'package:flutter/material.dart';
import 'package:its_shared/styles.dart';

class StatisticsWidgetNew extends StatelessWidget {
  const StatisticsWidgetNew({
    super.key,
    required this.title,
    required this.bgColor,
    required this.value,
    required this.icon,
  });
  final String title;
  final String value;
  final Color bgColor;
  final IconData icon;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(Insets.med),
      ),
      child: Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Insets.sm),
                    decoration: BoxDecoration(
                      color: bgColor.withValues(alpha: .35),
                      borderRadius: BorderRadius.circular(Insets.med),
                    ),
                    child: Icon(
                      icon,
                      color: bgColor,
                      size: 22,
                    ),
                  ),
                  HSpace.med,
                  Text(
                    value,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}