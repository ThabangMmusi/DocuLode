import 'package:doculode/config/index.dart';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:doculode/core/constants/app_constants.dart';

import 'package:doculode/presentation/app_title_bar/index.dart';
import 'loading_widget.dart';

//todo : clean codebase
class CustomDialogNew extends StatelessWidget {
  final String? header;
  final String? subHeader;
  final Widget content;
  final Widget? footer;
  final bool isInitializing;
  final bool isLoading;
  final bool showCloseButton;
  final String? initializingText, loadingText;
  final VoidCallback? onClose;
  final Widget? trailing;
  const CustomDialogNew(
      {super.key,
      this.header,
      required this.content,
      this.footer,
      this.subHeader,
      this.isInitializing = false,
      this.initializingText,
      this.isLoading = false,
      this.loadingText,
      this.onClose,
      this.trailing,
      this.showCloseButton = false});
  @override
  Widget build(BuildContext context) {
    return isInitializing
        ? Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(kPaddingDefault),
                child: LoadingWidget(
                  text: initializingText!,
                ),
              ),
            ),
          )
        : Dialog(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            insetAnimationDuration: const Duration(minutes: 350),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppTitleBar(),
                Expanded(child: Center(child: dialogContent(context))),
              ],
            ),
          );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Corners.medBorder,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (header != null)
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.all(Insets.xl),
                        child: Text(
                          header!,
                          style: TextStyles.headlineMedium,
                        ),
                      ),
                    ),
                  if (trailing != null) trailing!
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.xl),
                child: content,
              ),
              if (footer != null)
                Padding(
                  padding: const EdgeInsets.only(top: kPaddingHalf),
                  child: footer,
                ),
            ],
          ),
          if (showCloseButton)
            Positioned(
              right: Corners.lg,
              top: Corners.lg,
              child: CircularCloseButton(
                onClose: () {
                  Navigator.pop(context);
                  if (onClose != null) {
                    onClose!.call();
                  }
                },
              ),
            ),
          if (isLoading)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  color: Colors.white.withAlpha(235),
                  child: LoadingWidget(text: loadingText!)),
            ),
        ],
      ),
    );
  }
}

class CircularCloseButton extends StatefulWidget {
  const CircularCloseButton({
    super.key,
    required this.onClose,
  });
  final VoidCallback onClose;
  @override
  State<CircularCloseButton> createState() => _CircularCloseButtonState();
}

class _CircularCloseButtonState extends State<CircularCloseButton> {
  late Color? _color = Colors.grey[200];
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _color = Colors.red;
        });
        widget.onClose.call();
      },
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _color = Colors.red;
            hovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            _color = Colors.grey[200];
            hovered = false;
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Container(
              width: 32,
              height: 32,
              color: _color,
              child: Center(
                child: Icon(Ionicons.close,
                    size: 20, color: hovered ? Colors.white : Colors.red),
              )),
        ),
      ),
    );
  }
}
