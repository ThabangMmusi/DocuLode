import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class PageContentHeader extends StatefulWidget {
  const PageContentHeader({
    super.key,
    required this.header,
    this.subHeader,
    this.smallHeader = false,
  });
  final String header;
  final String? subHeader;
  final bool smallHeader;
  @override
  State<PageContentHeader> createState() => _PageContentHeaderState();
}

class _PageContentHeaderState extends State<PageContentHeader>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late String oldTitle = "";
  late String? oldSubtitle = "";
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(microseconds: 1));
    _animationController2 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(microseconds: 1));

    animate();
    // _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animate();
    return SizedBox(
      height:
          (widget.subHeader != null ? 60 : 46) - (widget.smallHeader ? 10 : 0),
      width: double.infinity,
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kPaddingHalf),
            child: Text(
              widget.header,
              maxLines: 1,
              style: TextStyle(
                fontSize: widget.smallHeader ? 18 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.subHeader != null)
            Positioned(
              top: 35,
              child: Padding(
                padding: const EdgeInsets.only(left: kPaddingHalf),
                child: Text(
                  widget.subHeader!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 13,
                      // fontWeight: FontWeight.bold,
                      color: tPrimaryColor.withAlpha(150)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void animate() {
    if (widget.header != oldTitle) {
      oldTitle = widget.header;
      _animationController.value = 0;
      _animationController.forward();
    }
    if (widget.subHeader != oldSubtitle) {
      oldSubtitle = widget.subHeader;
      _animationController2.value = 0;
      _animationController2.forward();
    }
  }
}
