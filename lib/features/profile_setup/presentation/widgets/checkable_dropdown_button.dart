// A reusable checkable dropdown button for multi-select with checkboxes.
import 'package:doculode/config/index.dart';
import 'package:doculode/widgets/buttons/primary_btn.dart';
import 'package:doculode/widgets/buttons/secondary_btn.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CheckableDropdownButton<T> extends StatefulWidget {
  final List<DropdownOption<T>> options;
  final Set<T> selectedValues;
  final String hintText;
  final void Function(Set<T>) onChanged;
  final String? label;
  final double? width;
  final bool isDense;

  const CheckableDropdownButton({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.hintText = 'Select...',
    this.label,
    this.width,
    this.isDense = false,
  });

  @override
  State<CheckableDropdownButton<T>> createState() =>
      _CheckableDropdownButtonState<T>();
}

class DropdownOption<T> {
  final String label;
  final T value;
  DropdownOption(this.label, this.value);
}

class _CheckableDropdownButtonState<T>
    extends State<CheckableDropdownButton<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late Set<T> _stagedSelectedValues;
  late final ButtonStyle _applyButtonStyle;

  @override
  void initState() {
    super.initState();
    _stagedSelectedValues = Set<T>.from(widget.selectedValues);
    _applyButtonStyle = FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: Corners.smBorder));
  }

  @override
  void didUpdateWidget(CheckableDropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the parent changes the selection and the dropdown is closed or
    // if the options themselves change, update the staged values to match.
    if (widget.selectedValues != oldWidget.selectedValues && !_isOpen) {
      _stagedSelectedValues = Set<T>.from(widget.selectedValues);
    }
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    // Initialize staged values from widget's current selection when opening
    _stagedSelectedValues = Set<T>.from(widget.selectedValues);
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final double overlayWidth = widget.width ?? size.width;
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Invisible layer to catch outside taps
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removeOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Dropdown content
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(-overlayWidth + size.width, size.height + 4),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Material(
                clipBehavior: Clip.antiAlias,
                elevation: 8,
                borderRadius: Corners.medBorder,
                child: Container(
                    constraints:
                        BoxConstraints(maxHeight: 260, maxWidth: overlayWidth),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: Corners.medBorder,
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ListView.builder(
                            // Removed wrapping Material
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: widget.options.length,
                            itemBuilder: (context, index) {
                              final DropdownOption<T> option =
                                  widget.options[index];
                              final bool isChecked =
                                  _stagedSelectedValues.contains(option.value);
                              final bool isFirstItem = index ==
                                  0; // Assuming first item is always at index 0

                              return CompactCheckboxListItem<T>(
                                key: ValueKey(option
                                    .value), // Helps Flutter optimize rebuilds
                                label: option.label,
                                value: option.value,
                                isChecked: isChecked,
                                isFirstItem: isFirstItem,
                                onChanged: (T value, bool? checked) {
                                  final newSet =
                                      Set<T>.from(_stagedSelectedValues);
                                  if (checked == true && mounted) {
                                    newSet.add(value);
                                  } else if (mounted) {
                                    newSet.remove(value);
                                  }
                                  if (mounted) {
                                      _stagedSelectedValues = newSet;
                                   
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: colorScheme.outline.withValues(alpha: 0.2),
                        ),
                        Container(
                          padding: EdgeInsets.all(Insets.sm),
                          width: double.infinity,
                          child: PrimaryBtn(
                            label: 'Apply',
                            onPressed: () {
                              widget.onChanged(_stagedSelectedValues);
                              _removeOverlay();
                            },
                            style: _applyButtonStyle,
                            isCompact: true,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  @override
  void dispose() {
    // Just remove the overlay entry without setState since we're disposing
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SecondaryBtn(
        onPressed: _toggleDropdown,
        // isCompact: truess, // Or adjust as needed
        // style: ButtonStyle(
        //   padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
        //       horizontal: 12,
        //       vertical: widget.isDense
        //           ? 6
        //           : 12)), // Adjusted padding for SecondaryBtn
        // You might want to customize the SecondaryBtn's style further
        // to match the previous appearance if needed.
        // For example, to match the border and background:
        // side: WidgetStatePropertyAll(BorderSide(
        //   color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
        // )),
        // backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
        // ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   mainAxisSize: MainAxisSize.min, // Add this line
        //   children: [
        //     Flexible(
        //       child: Text(
        //         widget.hintText,
        //         style: Theme.of(context)
        //             .textTheme
        //             .bodyMedium
        //             ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        //         overflow: TextOverflow.ellipsis,
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(
        //           left: Insets.xs / 2), // Adjusted padding to left for icon
        //       child: Icon(
        //         _isOpen
        //             ? Ionicons.chevron_up_outline
        //             : Ionicons.chevron_down_outline,
        //         color: Theme.of(context).colorScheme.onSurfaceVariant,
        //         size: IconSizes.sm,
        //       ),
        //     ),
        //   ],
        // ),
        icon: Ionicons.filter,
      ),
    );
  }
}

class CompactCheckboxListItem<T> extends StatefulWidget {
  final String label;
  final T value;
  bool isChecked;
  final bool isFirstItem;
  final void Function(T value, bool? checked) onChanged;

 CompactCheckboxListItem({
    super.key,
    required this.label,
    required this.value,
    required this.isChecked,
    required this.isFirstItem,
    required this.onChanged,
  });

  @override
  State<CompactCheckboxListItem<T>> createState() => _CompactCheckboxListItemState<T>();
}

class _CompactCheckboxListItemState<T> extends State<CompactCheckboxListItem<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      hoverColor:
          theme.colorScheme.onSurface.withOpacity(0.08), // Added hover color
      onTap: widget.isFirstItem ? null : () {
        setState(() {
          widget.isChecked = !widget.isChecked;
        });
        widget.onChanged(widget.value, widget.isChecked);
      },
      child: Padding(
        padding: EdgeInsets.all(Insets.sm), // Reduced vertical padding
        child: Row(
          children: [
            SizedBox(
              width: 24, // Constrain checkbox width
              height: 24, // Constrain checkbox height
              child: Icon(
                widget.isChecked
                    ? Ionicons.checkmark_circle
                    : Ionicons.ellipse_outline,
                size: IconSizes.med, // Adjust size as needed
                color: widget.isFirstItem
                    ? theme.disabledColor
                    : widget.isChecked
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            HSpace.xs,
            Expanded(
              child: Text(
                widget.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: widget.isFirstItem
                      ? theme.disabledColor
                      : theme.colorScheme.onSurface,
                  height: 1.2, // Adjust line height for tighter text
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
