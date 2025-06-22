import 'package:doculode/app/config/index.dart';
import 'package:doculode/core/widgets/index.dart';



















import 'package:flutter/material.dart';



class SetupSideImage extends StatelessWidget {
  const SetupSideImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return SizedBox(
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.all(Insets.lg),
        child: DecoratedContainer(
          color: colorScheme.primary,
          borderRadius: Corners.lg,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(Insets.xl),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Insets.xl),
                    child: Text(
                      "Take Control, Be in Control",
                      style: TextStyles.displayLarge.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  // VSpace.xl,
                  Transform.rotate(
                    angle: 12.5,
                    child: Container(
                      constraints:
                          const BoxConstraints(maxHeight: 400, maxWidth: 400),
                      // width: 400,
                      clipBehavior: Clip.antiAlias,
                      // height: 400,
                      decoration: const BoxDecoration(
                        borderRadius: Corners.lgBorder,
                        // border:
                      ),
                      child: Image.asset("assets/images/landing.jpg",
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
