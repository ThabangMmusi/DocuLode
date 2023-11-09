part of "side_menu_widget.dart";

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final course = context.select((AuthBloc bloc) => bloc.state.courseDetails!);

    return ListView.builder(
        itemCount: course.modules!.length,
        itemBuilder: (listContext, index) => MySideMenuButton(
              iconData: Ionicons.school_outline,
              activeIcon: Ionicons.school,
              index: index,
              title: course.modules![index],
            ));
  }
}
