import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:its_shared/styles.dart';
import 'package:its_shared/widgets/labeled_text_input.dart';

class StyledDropDownTextfield<T> extends StatefulWidget {
  final List<AppListItem<T>>? initialList;
  final double? radius;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? noItemFound;
  final String? label;
  final Future<List<AppListItem<T>>> Function()? future;
  final T? value;
  final ValueChanged<T>? onSelection;
  final int minStringLength;
  final int itemsInView;
  final Function(String)? onChanged;

  const StyledDropDownTextfield({
    super.key,
    required this.initialList,
    this.label,
    this.future,
    this.onSelection,
    this.noItemFound,
    this.radius,
    this.suffix,
    this.prefixIcon,
    this.itemsInView = 3,
    this.minStringLength = 2,
    this.hintText,
    this.value,
    this.onChanged,
  });

  @override
  State<StyledDropDownTextfield> createState() =>
      _StyledDropDownTextfieldState<T>();
}

class _StyledDropDownTextfieldState<T> extends State<StyledDropDownTextfield<T>>
    with WidgetsBindingObserver {
  late TextEditingController _controller;
  final GlobalKey _key = GlobalKey(debugLabel: "StyledDropDownTextfield");
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  AppListItem<T>? _selected;
  OverlayEntry? _overlay;
  FocusScopeNode? _focusScopeNode;
  List<AppListItem<T>>? filteredList = [];
  bool hasFuture = false;
  bool loading = false;
  final _debouncer = Debouncer(milliseconds: 500);
  bool? itemsFound;
  late ScrollController _scrollController;

  void resetList() {
    setState(() {
      filteredList = [];
      loading = false;
    });
    _overlay?.markNeedsBuild();
  }

  void setLoading() {
    if (!loading) {
      setState(() {
        loading = true;
      });
    }
  }

  void resetState(List<AppListItem<T>> tempList) {
    setState(() {
      filteredList = tempList;
      loading = false;
      itemsFound =
          tempList.isEmpty && _controller.text.isNotEmpty ? false : true;
    });
    _overlay?.markNeedsBuild();
  }

  void updateGetItems() {
    _overlay?.markNeedsBuild();
    if (_controller.text.length > widget.minStringLength) {
      setLoading();
      widget.future!().then((value) {
        filteredList = value;
        List<AppListItem<T>> tempList = [];
        for (AppListItem<T> item in filteredList!) {
          if (item.title
              .toLowerCase()
              .contains(_controller.text.toLowerCase())) {
            tempList.add(item);
          }
        }
        resetState(tempList);
      });
    } else {
      resetList();
    }
  }

  void updateList() {
    setLoading();
    filteredList = widget.initialList;
    List<AppListItem<T>> tempList = <AppListItem<T>>[];
    for (AppListItem<T> item in filteredList!) {
      if (item.title.toLowerCase().contains(_controller.text.toLowerCase())) {
        tempList.add(item);
      }
    }
    resetState(tempList);
  }

  void updateAllLists() {
    setState(() {
      if (hasFuture) {
        updateGetItems();
      } else {
        updateList();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _removeOverlay(); // Remove overlay when the app is paused or inactive
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add this widget as an observer
    _controller = TextEditingController();
    _scrollController = ScrollController();

    if (widget.initialList == null && widget.future == null) {
      throw ('Error: Missing required initial list or future that returns list');
    }
    if (widget.future != null) {
      setState(() {
        hasFuture = true;
      });
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (mounted) {
          _overlay = _createOverlay();
          Overlay.of(context).insert(_overlay!);
          updateAllLists();
        }
      }
    });
    if (widget.initialList!.isNotEmpty && widget.initialList != null) {
      if (widget.value != null) {
        _selected = widget.initialList!
            .firstWhere((listItem) => listItem.value == widget.value);
        _controller.text = _selected!.title;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: LabeledTextInput(
        // text: _selected?.title,
        key: _key,
        focusNode: _focusNode,
        suffix: widget.suffix,
        prefixIcon: widget.prefixIcon,
        controller: _controller,
        label: widget.label ?? "",
        hintText: widget.hintText,
        onSubmit: (p0) {
          if (mounted) {
            _removeOverlay(true);
          }
        },
        onChanged: (String value) {
          _debouncer.run(() {
            if (mounted) {
              updateAllLists();
              widget.onChanged?.call(value);
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
    _focusScopeNode?.dispose();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
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
                  node: _focusScopeNode!,
                  child: loading ? _loadingIndicator() : _listViewContainer(),
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

  void _removeOverlay([bool force = false]) {
    if (mounted && (!_focusNode.hasFocus || force)) {
      if (_overlay != null) {
        _overlay!.remove();
        _overlay = null;
      }
      if (mounted) {
        _focusScopeNode?.dispose();
        _focusScopeNode =
            null; // Ensure focus scope node is nullified after disposal
      }
    }
  }

  Widget _loadingIndicator() {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  Widget _listViewContainer() {
    if ((itemsFound == true && filteredList!.isNotEmpty) ||
        (itemsFound == false && widget.noItemFound != null)) {
      return SizedBox(
        height: calculateHeight().toDouble(),
        child: _createListItems(),
      );
    }
    return const SizedBox();
  }

  num heightByLength(int length) {
    return richInputHeight * length;
  }

  num calculateHeight() {
    if (filteredList!.length > 1) {
      if (widget.itemsInView <= filteredList!.length) {
        return heightByLength(widget.itemsInView);
      }
      return heightByLength(filteredList!.length);
    }
    return richInputHeight;
  }

  Widget _createListItems() {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: widget.radius != null
            ? BorderRadius.circular(widget.radius!)
            : BorderRadius.zero,
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0.6,
              color: Colors.black26)
        ],
      ),
      width: renderBox.size.width,
      child: (itemsFound == false && widget.noItemFound != null)
          ? BaseListItemWidget(showDivider: false, child: widget.noItemFound!)
          : ScrollConfiguration(
              behavior: const CustomScrollBehavior(),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: filteredList!.length,
                itemBuilder: (context, index) => BaseListItemWidget(
                  showDivider: index != 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(filteredList![index].title),
                    ],
                  ),
                  onPress: () => _onListItemTap(filteredList![index]),
                ),
              ),
            ),
    );
  }

  void _onListItemTap(AppListItem<T> listItem) {
    setState(() {
      if (widget.onSelection != null) {
        widget.onSelection?.call(listItem.value);
      }
      _controller.text = listItem.title;
    });
    _removeOverlay();
    FocusScope.of(context).unfocus();
  }
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}

const double richInputHeight = 44;

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      thumbVisibility: true,
      controller: details.controller,
      child: child,
    );
  }
}

class AppListItem<T> {
  final String title;
  final T value;

  const AppListItem(
    this.title, {
    required this.value,
  });
}

class BaseListItemWidget extends StatelessWidget {
  const BaseListItemWidget(
      {super.key, required this.child, this.onPress, this.showDivider = true});
  final VoidCallback? onPress;
  final Widget child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        child: Container(
            height: richInputHeight,
            padding: EdgeInsets.symmetric(horizontal: Insets.med),
            decoration: BoxDecoration(
                border: Border(
                    top: !showDivider
                        ? BorderSide.none
                        : BorderSide(color: Theme.of(context).dividerColor))),
            child: Row(
              children: [
                child,
              ],
            )),
      ),
    );
  }
}
