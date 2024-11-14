import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/decorated_container.dart';

import '../../../animated/animated.dart';
import '../../../core/bloc/auth/auth_bloc.dart';
import '../../../constants/responsive.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView>
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
                // SignOutButton(),
                // kVSpacingDefault,
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
                Text(user!.getFullNames,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    )),
                VSpace.lg,
                const _UserStatsWidget(),
                VSpace.sm,
                const Divider(),
                // const UserCourseWidget(),
              ],
            ),
          ),
        ));
  }
}

class UserCourseWidget extends StatelessWidget {
  const UserCourseWidget({
    super.key,
  });

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
              // valueBuilder(context, "Course Code", course.code),
              valueBuilder(context, "Course Year", "${user.level}} year"),
              // valueBuilder("School", course.schoolFullName),
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
          child: Text(
            value,
          ),
        ),
      ],
    );
  }
}

class _UserStatsWidget extends StatelessWidget {
  const _UserStatsWidget();

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: DecoratedContainer(
        // borderRadius: Corners.med,
        // padding: EdgeInsets.all(Insets.med),
        // color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _StatsButton(icon: Ionicons.share, title: "2"),
            // _StatsButton(icon: Ionicons.download, title: "50"),
            _StatsButton(icon: Ionicons.heart, title: "46"),
            _StatsButton(icon: Ionicons.heart_dislike, title: "5"),
          ],
        ),
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
