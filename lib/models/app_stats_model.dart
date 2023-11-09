// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppStatsModel extends Equatable {
  final int counts;
  final String? title;
  final Color? color;
  final IconData? icon;
  const AppStatsModel({
    required this.counts,
    this.title,
    this.color,
    this.icon,
  });

  @override
  List<Object?> get props => [title, counts, color, icon];
}

List<AppStatsModel> tempStats() {
  return [
    const AppStatsModel(
        title: "Schools",
        counts: 3,
        color: Color(0xFF9BCAB8),
        icon: Ionicons.school),
    const AppStatsModel(
      title: "Uploads files",
      counts: 12000,
      color: Color(0xFFFFB7C3),
      icon: Ionicons.book,
    ),
    const AppStatsModel(
      title: "Likes on files",
      counts: 200,
      color: Color.fromARGB(255, 252, 199, 119),
      icon: Ionicons.heart,
    ),
    const AppStatsModel(
        title: "Current Users",
        counts: 3300,
        color: Color.fromARGB(255, 159, 197, 97),
        icon: Ionicons.person),
  ];
}
