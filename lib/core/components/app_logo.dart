import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doculode/core/constants/app_text.dart';

enum LogoVariant {
  /// Shows both logo and text vertically aligned
  vertical,

  /// Shows both logo and text vertically aligned in white
  verticalWhite,

  /// Shows only the logo
  logoOnly,
  logoOnlyWhite,

  /// Shows logo and text horizontally aligned
  horizontal,

  /// Shows logo and text horizontally aligned in white
  horizontalWhite,
}

class AppLogo extends StatelessWidget {
  final LogoVariant variant;
  final double? size;
  final bool showSlogan;
  final bool showVersion;

  const AppLogo({
    super.key,
    this.variant = LogoVariant.vertical,
    this.size,
    this.showSlogan = false,
    this.showVersion = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isWhite = variant == LogoVariant.verticalWhite ||
        variant == LogoVariant.horizontalWhite || variant == LogoVariant.logoOnlyWhite;
    final bool isHorizontal = variant == LogoVariant.horizontal ||
        variant == LogoVariant.horizontalWhite;

    // Calculate sizes
    final double logoSize = size ?? 40.0;
    final double fontSize = logoSize * 0.5;
    final double sloganSize = fontSize * 0.6;
    final double versionSize = fontSize * 0.5;
    final double spacing = logoSize * 0.25;

    final logo = SvgPicture.asset(
      isWhite ? 'assets/logos/app_logo_white.svg' : 'assets/logos/app_logo.svg',
      width: logoSize,
      height: logoSize,
    );

    final appName = Text(
      tAppName,
      style: TextStyle(
        color: isWhite ? Colors.white : colorScheme.primary,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );

    final slogan = showSlogan
        ? Text(
            tAppSlogan,
            style: TextStyle(
              color: (isWhite ? Colors.white : colorScheme.inverseSurface)
                  .withOpacity(0.7),
              fontSize: sloganSize,
            ),
            textAlign: TextAlign.center,
          )
        : null;

    final version = showVersion
        ? Text(
            tAppVersion,
            style: TextStyle(
              color: (isWhite ? Colors.white : colorScheme.inverseSurface)
                  .withOpacity(0.5),
              fontSize: versionSize,
            ),
            textAlign: TextAlign.center,
          )
        : null;

    if (variant == LogoVariant.logoOnly || variant == LogoVariant.logoOnlyWhite) {
      return Center(child: logo);
    }

    if (isHorizontal) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logo,
            SizedBox(width: spacing),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appName,
                if (slogan != null) ...[
                  SizedBox(height: spacing / 2),
                  slogan,
                ],
                if (version != null) ...[
                  SizedBox(height: spacing / 2),
                  version,
                ],
              ],
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          SizedBox(height: spacing),
          appName,
          if (slogan != null) ...[
            SizedBox(height: spacing / 2),
            slogan,
          ],
          if (version != null) ...[
            SizedBox(height: spacing / 2),
            version,
          ],
        ],
      ),
    );
  }
}
