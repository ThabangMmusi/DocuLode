import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../animated/animated.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
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
        duration: const Duration(milliseconds: 500),
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
    return SlideFadeAnimation(
        animation: _animationController,
        child: Container(
          height: double.infinity,
          width: Responsive.isDesktop(context) ? 280 : double.infinity,
          padding: const EdgeInsets.all(kPaddingDefault),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SignOutButton(),
                // kVSpacingDefault,
                kVSpacingHalf,
                CircleAvatar(
                  radius: 82,
                  backgroundColor: tPrimaryColor.withAlpha(40),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: tPrimaryColor.withAlpha(100),
                    radius: 80,
                    child: const Icon(
                      Ionicons.person,
                      size: 96,
                    ),
                  ),
                ),
                kVSpacingDefault,
                Text(user!.getFullNames,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    )),
                kVSpacingDefault,
                const _UserStatsWidget(),
                const Padding(
                  padding: EdgeInsets.only(top: kPaddingHalf),
                  child: Divider(),
                ),
                const UserCourseWidget(),
                TextButton(
                    onPressed: () async {
                      // final token = await Authuser!.getIdToken();
                      // print(token);
                      // Process.start('grep', ['-i', 'main', 'notepad.exe'])
                      //     .then((result) {
                      //   stdout.write(result.stdout);
                      //   stderr.write(result.stderr);
                      // });
                    },
                    child: const Text("Token")),
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
    final course = context.select((AuthBloc bloc) => bloc.state.courseDetails!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        valueBuilder("Course", course.name),
        valueBuilder("Course Code", course.code),
        valueBuilder("Course Year", "${course.year} year"),
        valueBuilder("School", course.schoolFullName),
        valueBuilder("Total Modules", course.modules!.length.toString()),
      ],
    );
  }

  Widget valueBuilder(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVSpacingHalf,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kPaddingQuarter),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black45, fontSize: 12),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(kPaddingQuarter),
          decoration: BoxDecoration(
              color: tPrimaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(kPaddingQuarter)),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatsButton(icon: Ionicons.share, title: "2"),
          _StatsButton(icon: Ionicons.download, title: "50"),
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
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.black87,
          foregroundColor: tWhiteColor,
          child: Icon(
            icon,
            size: 16,
          ),
        ),
        kVSpacingQuarter,
        Text(title)
      ],
    );
  }
}
