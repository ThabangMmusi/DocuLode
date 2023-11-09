part of "side_menu_widget.dart";

class MenuCategoryTitle extends StatelessWidget {
  const MenuCategoryTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.start,
      style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
    );
  }
}
