import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import 'loading_widget.dart';
import 'page_content_header.dart';

class CustomDialogNew extends StatelessWidget {
  final String header;
  final String? subHeader;
  final Widget content;
  final Widget? footer;
  final bool isInitializing;
  final bool isLoading;
  final String? initializingText, loadingText;
  final BoxConstraints constraints;
  final VoidCallback? onClose;
  final Widget? trailing;
  const CustomDialogNew(
      {super.key,
      required this.header,
      required this.content,
      this.footer,
      this.subHeader,
      this.isInitializing = false,
      this.initializingText,
      this.isLoading = false,
      this.loadingText,
      required this.constraints,
      this.onClose,
      this.trailing});
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
            backgroundColor: Colors.white,
            child: dialogContent(context),
          );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Positioned(
                right: kPaddingQuarter,
                top: kPaddingQuarter,
                child: CircularCloseButton(
                  onClose: () {
                    Get.back();
                    if (onClose != null) {
                      onClose!.call();
                    }
                  },
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      constraints:
                          BoxConstraints(maxWidth: constraints.maxWidth),
                      padding: const EdgeInsets.only(left: kPaddingHalf),
                      child: Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: kPaddingHalf, bottom: 3),
                              child: PageContentHeader(
                                header: header,
                                subHeader: subHeader,
                              ),
                            ),
                          ),
                          if (trailing != null) trailing!
                        ],
                      )),
                ]),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: kPaddingHalf, right: kPaddingHalf),
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(color: tDarkColor.withOpacity(.5)),
                              bottom: footer != null
                                  ? BorderSide(
                                      color: tDarkColor.withOpacity(.5))
                                  : BorderSide.none)),
                      child: ConstrainedBox(
                          constraints: constraints, child: content),
                    ),
                    if (footer != null)
                      Padding(
                        padding: const EdgeInsets.only(top: kPaddingHalf),
                        child: footer,
                      ),
                  ],
                ),
              ],
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
        ));
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
