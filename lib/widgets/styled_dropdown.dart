import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:its_shared/styles.dart';

import 'styled_dropdown_textfield.dart';
import 'ui_text.dart';

class StyledDropDown<T> extends StatefulWidget {
  final List<AppListItem<T>> listItems;
  final String label;

  /// Text that appears when no item is selected yet.
  final String placeHolder;
  final T? value;
  final ValueChanged<T?>? onChange;
  final FormFieldValidator<T>? fieldValidator;

  /// The number of matched items that are viewable in results
  final int itemsInView;

  const StyledDropDown({
    Key? key,
    required this.listItems,
    required this.label,
    this.value,
    this.onChange,
    this.fieldValidator,
    this.itemsInView = 3,
    this.placeHolder = "Select",
  }) : super(key: key);

  @override
  State<StyledDropDown<T>> createState() => _StyledDropDownState<T>();
}

class _StyledDropDownState<T> extends State<StyledDropDown<T>> {
  final GlobalKey _key = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  AppListItem? _selected;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isOverlayShown = false;
  OverlayEntry? _overlay;
  FocusScopeNode? _focusScopeNode;

  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    if (widget.listItems.isNotEmpty) {
      // if (widget.value == null) {
      //   _selected = widget.listItems.first;
      // }
      // else
      if (widget.value != null) {
        _selected = widget.listItems
            .firstWhere((listItem) => listItem.value == widget.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return FormField(
        validator: (value) {
          if (widget.fieldValidator != null) {
            if (widget.value == null) {
              if (_selected != null) {
                return widget.fieldValidator!.call(_selected!.value);
              } else {
                return widget.fieldValidator!.call(null);
              }
            } else {
              return widget.fieldValidator!.call(widget.value);
            }
          }
          return null;
        },
        initialValue: _selected != null ? _selected!.value : widget.placeHolder,
        builder: (formFieldState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiText(text: widget.label, style: theme.textTheme.bodyMedium),
              VSpace.xs,

              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: _onTap,
                  child: FocusableActionDetector(
                    focusNode: _focusNode,
                    mouseCursor: SystemMouseCursors.click,
                    actions: {
                      ActivateIntent:
                          CallbackAction<Intent>(onInvoke: (_) => _onTap()),
                    },
                    onShowFocusHighlight: (isFocused) =>
                        setState(() => _isFocused = isFocused),
                    onShowHoverHighlight: (isHovered) =>
                        setState(() => _isHovered = isHovered),
                    child: Container(
                      key: _key,
                      height: 42,
                      padding: EdgeInsets.symmetric(horizontal: Insets.med),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        border: Border.all(
                          color: _isHovered || _isFocused || _isOverlayShown
                              ? colorScheme.primary
                              : theme.inputDecorationTheme.enabledBorder != null
                                  ? theme.inputDecorationTheme.enabledBorder!
                                      .borderSide.color
                                  : Colors.grey,
                        ),
                        borderRadius: Corners.smBorder,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selected == null
                                ? widget.placeHolder
                                : _selected!.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // if (!formFieldState.hasError)
              //   const SizedBox(
              //     height: 15,
              //   ),
              // if (formFieldState.hasError)
              //   ErrorMessageWidget(errorMessage: formFieldState.errorText)
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _focusScopeNode?.dispose();
    _scrollController.dispose();
  }

  OverlayEntry _createOverlay() {
    _focusScopeNode = FocusScopeNode();
    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              child: Material(
                color: Colors.transparent,
                child: FocusScope(
                  node: _focusScopeNode,
                  child: _listViewContainer(),
                  onKey: (node, event) {
                    if (event.logicalKey == LogicalKeyboardKey.escape) {
                      _removeOverlay();
                    }

                    return KeyEventResult.ignored;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlay!.remove();
    _isOverlayShown = false;
    _focusScopeNode!.dispose();
    // FocusScope.of(context).nextFocus();
  }

  Widget _listViewContainer() {
    return SizedBox(
        height: calculateHeight().toDouble(), child: _createAppListItems());
  }

  num heightByLength(int length) {
    return (richInputHeight) * length;
  }

  num calculateHeight() {
    if (widget.listItems.length > 1) {
      if (widget.itemsInView <= widget.listItems.length) {
        return heightByLength(widget.itemsInView);
      }

      return heightByLength(widget.listItems.length);
    }

    return richInputHeight;
  }

  Widget _createAppListItems() {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;

    return Container(
        // padding: const EdgeInsets.symmetric(vertical: richPaddingHalf),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          // border: Border.all(
          //   color: Theme.of(context).primaryColor,
          // ),
          borderRadius: Corners.smBorder,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0.6,
                color: Colors.black26)
          ],
        ),
        width: renderBox.size.width,
        child: ScrollConfiguration(
            behavior: const CustomScrollBehavior(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.listItems.length,
              itemBuilder: (context, index) => BaseListItemWidget(
                showDivider: index != 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.listItems[index].title),
                    // IconButton(
                    //     onPressed: () {
                    //       _removeOverlay();
                    //     },
                    //     icon: const Icon(Icons.cancel_outlined))
                  ],
                ),
                onPress: () => _onAppListItemTap(widget.listItems[index]),
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // children: filteredList!
                //     .map((listItem) =>
                //         ))
                // .toList(),
              ),
            )));
  }

  // Widget _createAppListItems() {
  //   RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;

  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: richPaddingHalf),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).scaffoldBackgroundColor,
  //       border: Border.all(
  //         color: Theme.of(context).primaryColor,
  //       ),
  //       borderRadius: widget.radius != null
  //           ? BorderRadius.circular(widget.radius!)
  //           : BorderRadius.zero,
  //     ),
  //     width: renderBox.size.width,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: widget.listItems
  //           .map((listItem) => AppListItem(
  //                 listItem.title,
  //                 onTap: () => _onAppListItemTap(listItem),
  //               ))
  //           .toList(),
  //     ),
  //   );
  // }

  void _onTap() {
    if (_isOverlayShown) {
      _removeOverlay();
    } else {
      _overlay = _createOverlay();
      Overlay.of(context).insert(_overlay!);
      _isOverlayShown = true;
      FocusScope.of(context).setFirstFocus(_focusScopeNode!);
    }
  }

  void _onAppListItemTap(AppListItem listItem) {
    _removeOverlay();
    setState(() {
      _selected = listItem;
    });

    widget.onChange?.call(listItem.value);
  }
}
