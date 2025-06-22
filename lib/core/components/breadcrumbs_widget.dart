import 'package:doculode/app/config/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BreadcrumbsWidget extends StatelessWidget {
  const BreadcrumbsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter.of(context);
    final String location = router.routerDelegate.currentConfiguration.fullPath;

    // Split the path into segments and filter out empty strings
    final List<String> segments = location.split('/').where((s) => s.isNotEmpty).toList();

    return Container(
        decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: Corners.fullBorder,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 10,
                      spreadRadius: 4,
                    ),
                  ],
        ),
      child: Row(
        children: _buildBreadcrumbItems(context, segments),
      ),
    );
  }

  List<Widget> _buildBreadcrumbItems(BuildContext context, List<String> segments) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final List<Widget> items = [];
    for (int i = 0; i < segments.length; i++) {
      final String segment = segments[i];
      final String path = '/${segments.sublist(0, i + 1).join('/')}';
      final bool isLast = i == segments.length - 1;

      // Determine if the route is clickable
      final bool clickable = _allowClick(segment);

      Widget breadcrumbContent;
      if (segment == 'home') {
        breadcrumbContent = Row(
          children: [
            const Icon(Icons.home, size: 18.0),
            const SizedBox(width: 4.0),
            Text(
              _getDisplayName(segment),
              style: TextStyle(
                color: clickable ? Colors.blue : Colors.black,
                fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      } else if (segment == 'auth' || segment == 'setup') {
        breadcrumbContent = Container(
          // padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey),
          //   borderRadius: Corners.fullBorder,
          // ),
          child: Text(
            'Getting Started',
            style:textTheme.labelSmall?.copyWith(
              color: clickable ? Colors.blue : Colors.black,
              fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      } else {
        breadcrumbContent = Text(
          _getDisplayName(segment),
           style:textTheme.labelSmall?.copyWith(
            color: clickable ? Colors.blue : Colors.black,
            // fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }

      items.add(
        GestureDetector(
          onTap: clickable && !isLast
              ? () {
                  GoRouter.of(context).go(path);
                }
              : null,
          child: breadcrumbContent,
        ),
      );

      if (!isLast) {
        items.add(const Text(' > '));
      }
    }
    return items;
  }

  bool _allowClick(String segment) {
    // Routes that don't allow click are 'signin' and 'setup'
    return !['signin', 'setup', "auth"].contains(segment);
  }

  String _getDisplayName(String segment) {
    // Convert segment to a more readable display name if needed
    return segment.replaceAll('-', ' ').split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}