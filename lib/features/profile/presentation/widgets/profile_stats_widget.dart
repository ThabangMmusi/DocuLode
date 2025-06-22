import 'package:doculode/app/config/index.dart';













import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


class UserStatsWidget extends StatelessWidget {
  const UserStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatsButton(icon: Ionicons.share, title: "2"),
          _StatsButton(icon: Ionicons.heart, title: "46"),
          _StatsButton(icon: Ionicons.heart_dislike, title: "5"),
        ],
      ),
    );
  }
}

class _StatsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  const _StatsButton({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.onSurface,
          foregroundColor: colorScheme.onPrimary,
          child: Icon(
            icon,
            size: 16,
          ),
        ),
        HSpace.med,
        Text(title)
      ],
    );
  }
}