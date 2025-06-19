import 'package:doculode/config/index.dart';
import 'package:doculode/core/constants/index.dart';
import 'package:doculode/widgets/animated/animated.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'package:doculode/core/common/auth/presentation/bloc/auth_bloc.dart';
import 'package:doculode/features/profile/presentation/widgets/profile_stats_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 100));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SlideFadeAnimation(
        animation: _animationController,
        child: Container(
          height: double.infinity,
          width: Responsive.isDesktop(context) ? 300 : double.infinity,
          margin: EdgeInsets.all(Insets.med).copyWith(left: 0),
          decoration: BoxDecoration(
              color: colorScheme.surface, borderRadius: Corners.medBorder),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Insets.lg),
            child: Column(
              children: [
                VSpace.lg,
                CircleAvatar(
                  radius: 52,
                  backgroundColor: colorScheme.tertiaryContainer,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: colorScheme.tertiaryContainer,
                    radius: 50,
                    child: const Icon(
                      Ionicons.person,
                      size: 72,
                    ),
                  ),
                ),
                VSpace.lg,
                Text("${user!.surname} ${user.names}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    )),
                VSpace.lg,
                const UserStatsWidget(),
                VSpace.sm,
                const Divider(),
              ],
            ),
          ),
        ));
  }
}

class UserCourseWidget extends StatelessWidget {
  const UserCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    final user = state.user!;
    final course = user.course;
    final modules = user.modules;
    return course == null
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              valueBuilder(context, "Course", course.name!),
              valueBuilder(context, "Course Year", "${user.year}} year"),
              valueBuilder(
                  context, "Total Modules", modules!.length.toString()),
            ],
          );
  }

  Widget valueBuilder(BuildContext context, String title, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace.lg,
        Text(
          title,
          style: const TextStyle(color: Colors.black45, fontSize: 12),
        ),
        VSpace.xs,
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Insets.sm),
          decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: Corners.medBorder),
          child: Text(value),
        ),
      ],
    );
  }
}
