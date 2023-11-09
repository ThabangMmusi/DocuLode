import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../constants/responsive.dart';
import 'slide_fade_transaction.dart';

class MySideMenuButton extends StatefulWidget {
  final List<Widget>? items;
  final ValueChanged<int>? onItemPress;
  final int index;
  final String title;
  final IconData? iconData;
  final IconData? activeIcon;
  final VoidCallback? onPressed;
  final bool canBeSelected;
  bool isSelected;

  MySideMenuButton(
      {super.key,
      this.items,
      this.onItemPress,
      required this.index,
      required this.title,
      required this.iconData,
      this.onPressed,
      this.canBeSelected = true,
      this.isSelected = false,
      this.activeIcon});
  @override
  State<MySideMenuButton> createState() => _MySideMenuButtonState();
}

class _MySideMenuButtonState extends State<MySideMenuButton>
    with SingleTickerProviderStateMixin {
  GlobalKey? _key;
  bool isMenuOpen = false;
  bool isTooltipShown = false;
  late FocusNode _focusNode;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 100));
    _key = LabeledGlobalKey("button_icon");
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox? renderBox =
        _key!.currentContext!.findRenderObject() as RenderBox?;
    buttonSize = renderBox!.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  Future<void> closeMenu(BuildContext context, [bool openAgain = false]) async {
    // bool isTooltip = false;
    await _animationController.reverse().then((value) {
      _overlayEntry.remove();
      // if (isMenuOpen) {
      //   openAgain = true;
      //   isTooltip = true;
      // }
      isMenuOpen = false;
      isTooltipShown = false;
      if (openAgain) {
        openMenu(context);
      }
    });
  }

  void openMenu(BuildContext context, [bool tooltip = false]) {
    findButton();
    // debugPrint("is hovered ${widget.title}? ${_hovered.toString()}");
    _animationController.forward();
    _overlayEntry =
        !tooltip ? _overlayEntryBuilder() : _overlayEntryTooltipBuilder();
    Overlay.of(context).insert(_overlayEntry);

    if (!tooltip) {
      isMenuOpen = true;
      _focusNode.requestFocus();
    } else {
      isTooltipShown = true;
    }
  }

  bool _hovered = false;
  // final SideMenuController controller = SideMenuController.to;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (event) {
        if (!isMenuOpen) {
          setState(() {
            _hovered = event;
            if (!event) {
              if (Responsive.isTablet(context) && isTooltipShown) {
                closeMenu(context);
              }
            } else {
              if (Responsive.isTablet(context) && !isTooltipShown) {
                openMenu(context, true);
              }
            }
          });
        }
      },
      key: _key,
      focusNode: _focusNode,
      onFocusChange: (val) {
        setState(() {
          // print("Focus changed0");
          if (!val && isMenuOpen) {
            closeMenu(context);
            _hovered = false;
          }
        });
      },
      onTap: _onTap(context),
      child: Container(
        padding: const EdgeInsets.all(kPaddingDefault / 2),
        height: 42,
        color: tPrimaryColor.withOpacity(_hovered ? 0.03 : 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Responsive.isTablet(context)) kHSpacingHalf,
            if (Responsive.isTablet(context)) kHSpacingQuarter,
            Icon(
              widget.isSelected ? widget.activeIcon : widget.iconData,
              color: widget.isSelected ? Colors.black : Colors.black54,
            ),
            if (!Responsive.isTablet(context)) kHSpacingDefault,
            if (!Responsive.isTablet(context))
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: widget.isSelected ? Colors.black : Colors.black54,
                    fontSize: 14.4,
                    fontWeight: FontWeight.w500),
              ),
          ],
        ),
      ),
    );
  }

  Function()? _onTap(BuildContext context) {
    return widget.onPressed != null
        ? () async {
            if (widget.canBeSelected) {
              setState(() {
                widget.isSelected = true;
              });
            }
            if (isTooltipShown) {
              closeMenu(context);
              await Future.delayed(const Duration(milliseconds: 105));
            }
            if (Responsive.isMobile(context)) {
              Navigator.pop(context);
              _focusNode.requestFocus();
            }
            widget.onPressed!.call();
          }
        : widget.items != null
            ? () {
                // debugPrint("is menu open? ${isMenuOpen.toString()}");
                if (isTooltipShown) {
                  closeMenu(context, true);
                } else if (isMenuOpen) {
                  closeMenu(context);
                } else {
                  openMenu(context);
                }
              }
            : null;
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy,
          left: buttonPosition.dx + buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                SlideFadeTransition(
                  animation: _animationController,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0, bottom: 10, right: 10),
                    child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(widget.items!.length, (index) {
                          return GestureDetector(
                            onTap: () async {
                              await closeMenu(context);
                              widget.onItemPress!(index);
                              setState(() {
                                _hovered = false;
                                // controller.setSelected(index);
                              });
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      Responsive.isMobile(context) ? 210 : 250),
                              child: widget.items![index],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OverlayEntry _overlayEntryTooltipBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + (buttonSize.height - kPaddingDefault) / 2,
          left: buttonPosition.dx + buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: SlideFadeTransition(
              animation: _animationController,
              child: Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  height: kPaddingDefault,
                  margin: const EdgeInsets.only(left: kPaddingHalf),
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingHalf),
                  decoration: BoxDecoration(
                      color: tPrimaryColor.withAlpha(190),
                      borderRadius: BorderRadius.circular(kPaddingHalf)),
                  child: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
          ),
        );
      },
    );
  }
}
