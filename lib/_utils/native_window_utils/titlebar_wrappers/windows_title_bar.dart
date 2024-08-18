import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

/// Native TitleBar for Windows, uses BitDojo platform
class WindowsTitleBar extends StatelessWidget {
  const WindowsTitleBar(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final WindowButtonColors btnColors = WindowButtonColors(
      iconNormal: Colors.black,
      mouseOver: Colors.black.withOpacity(.2),
      mouseDown: Colors.black.withOpacity(.3),
      normal: Theme.of(context).colorScheme.surface,
    );
    final defaultCloseButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Colors.black,
      iconMouseOver: const Color(0xFFFFFFFF),
      normal: Theme.of(context).colorScheme.surface,
    );
    return SizedBox(
      height: 30,
      child: Stack(
        children: [
          MoveWindow(),
          child,
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MinimizeWindowButton(colors: btnColors),
                MaximizeWindowButton(colors: btnColors),
                CloseWindowButton(
                  colors: defaultCloseButtonColors,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
