import 'package:flutter/material.dart';

import 'styles.dart';

class AppTheme {
  static Color greenSurface = const Color(0xFF2C8769);
  static Color blueSurface = const Color(0xFF0061FE);
  static Color greenSurfaceDark = const Color(0xFF206F54);
  static Color blueSurfaceDark = const Color(0xFF004BC2);

  static const Color surface1 = Color(0xffFAFAFA);
  static const Color bg1 = Color(0xfff3f3f3);
  static const Color surface2 = Color.fromARGB(55, 21, 23, 24);
  static const Color accent1 = Color(0xffff392b);
  static const Color accent2 = Color.fromARGB(255, 230, 42, 29);
  static const Color greyWeak = Color(0xffcccccc);
  static const Color grey = Color(0xff535353);
  static const Color greyMedium = Color(0xff787878);
  static const Color greyStrong = Color(0xff333333);
  static const Color focus = Color(0xffd81e1e);
  static const Color mainTextColor = Colors.black;
  static const Color inverseTextColor = Colors.white;

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;
    final int alpha = color.alpha;

    final Map<int, Color> shades = {
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(color.value, shades);
  }

  static ThemeData get light {
    // ColorScheme colorScheme = ColorScheme.fromSeed(
    //   seedColor: const Color(0xffff392b),
    //   background: const Color(0XFFFAFAFA),
    //   onSecondary: Colors.white,
    //   secondary: const Color(0XFFE8E8E8),
    // );

    /// This will add luminance in dark mode, and remove it in light.
    // Allows the view to just make something "stronger" or "weaker" without worrying what the current theme brightness is
    //      color = theme.shift(someColor, .1); //-10% lum in dark mode, +10% in light mode
    Color shift(Color c, double amt) {
      amt *= (1);
      var hslc = HSLColor.fromColor(c); // Convert to HSL
      double lightness = (hslc.lightness + amt).clamp(0, 1.0)
          as double; // Add/Remove lightness
      return hslc.withLightness(lightness).toColor(); // Convert back to Color
    }

    final colorScheme = ColorScheme(
        brightness: Brightness.light,
        primary: accent1,
        primaryContainer: shift(accent1, .1),
        secondary: accent2,
        secondaryContainer: shift(accent2, .1),
        surface: surface1,
        onSurface: mainTextColor,
        onError: mainTextColor,
        onPrimary: inverseTextColor,
        onSecondary: inverseTextColor,
        inversePrimary: greyStrong,
        inverseSurface: grey,
        onInverseSurface: greyMedium,
        tertiary: greyWeak,
        tertiaryContainer: const Color(0XFFE8E8E8),
        onTertiaryContainer: const Color(0xFFFCFCFC),
        error: focus);

    Color dividerColor = const Color(0XFFE8E8E8);
    BorderSide dInputBS = BorderSide(color: colorScheme.primary);
    return ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.white),
      colorScheme: colorScheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: DividerThemeData(
          color: dividerColor, thickness: 1, space: Insets.med * 2),
      searchBarTheme: SearchBarThemeData(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(colorScheme.background),
        // side: MaterialStateProperty.all(dInputBS),
        // shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //     side: dInputBS, borderRadius: Corners.medBorder))
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primary,
        selectedShadowColor: Colors.transparent,
        secondarySelectedColor: Colors.lightBlue,
        // secondarySelectedShadowColor: Colors.transparent,
        backgroundColor: colorScheme.tertiaryContainer,
        disabledColor: Colors.grey,
        // disabledShadowColor: Colors.transparent,
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(Insets.med)),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.sm))),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(Insets.med)),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.sm))),
      )),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(Insets.med)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.sm))),
      )),
      switchTheme: SwitchThemeData(
          splashRadius: 0,
          thumbColor: MaterialStateProperty.all(colorScheme.onSecondary),
          trackColor: MaterialStateProperty.all(dividerColor),
          trackOutlineWidth: const MaterialStatePropertyAll(0),
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent)),
      tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab, labelStyle: TextStyles.h3),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 16, 46, 59),
      ),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF1EEB62),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ThemeData toThemeData({bool isDark = false}) {
//   const Color surface1 = Color(0xffFAFAFA);
//   const Color surface2 = Color.fromARGB(55, 21, 23, 24);
//   const Color accent1 = Color(0xffff392b);
//   const Color accent2 = Color.fromARGB(255, 230, 42, 29);
//   const Color greyWeak = Color(0xffcccccc);
//   const Color grey = Color(0xff535353);
//   const Color greyMedium = Color(0xff787878);
//   const Color greyStrong = Color(0xff333333);
//   const Color focus = Color(0xffd81e1e);
//   Color mainTextColor = isDark ? Colors.white : Colors.black;
//   Color inverseTextColor = isDark ? Colors.black : Colors.white;

//   /// This will add luminance in dark mode, and remove it in light.
//   // Allows the view to just make something "stronger" or "weaker" without worrying what the current theme brightness is
//   //      color = theme.shift(someColor, .1); //-10% lum in dark mode, +10% in light mode
//   Color shift(Color c, double amt) {
//     amt *= (isDark ? -1 : 1);
//     var hslc = HSLColor.fromColor(c); // Convert to HSL
//     double lightness =
//         (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
//     return hslc.withLightness(lightness).toColor(); // Convert back to Color
//   }

//   final colorScheme = ColorScheme(
//       brightness: isDark ? Brightness.dark : Brightness.light,
//       primary: accent1,
//       primaryContainer: shift(accent1, .1),
//       secondary: accent2,
//       secondaryContainer: shift(accent2, .1),
//       surface: surface1,
//       onSurface: mainTextColor,
//       onError: mainTextColor,
//       onPrimary: inverseTextColor,
//       onSecondary: inverseTextColor,
//       inversePrimary: greyStrong,
//       inverseSurface: grey,
//       onInverseSurface: greyMedium,
//       tertiary: greyWeak,
//       tertiaryContainer: const Color(0XFFE8E8E8),
//       onTertiaryContainer: const Color(0xFFFCFCFC),
//       error: focus);
//   Color dividerColor = colorScheme.tertiaryContainer;
//   BorderSide dInputBS = BorderSide(color: colorScheme.primary);

//   ThemeData t = ThemeData.from(
//     // fontFamily: Fonts.raleway,
//     // Use the .dark() and .light() constructors to handle the text themes
//     // textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
//     // Use ColorScheme to generate the bulk of the color theme
//     useMaterial3: true,
//     colorScheme: colorScheme,
//   );

//   // Apply additional styling that is missed by ColorScheme
//   t.copyWith(
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: colorScheme.surface,
//         contentPadding:
//             EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.lg),
//         border: const OutlineInputBorder(
//             borderSide: BorderSide.none,
//             gapPadding: 0,
//             borderRadius: Corners.medBorder),
//         focusedBorder: OutlineInputBorder(
//             borderSide: dInputBS,
//             gapPadding: 0,
//             borderRadius: Corners.medBorder),
//       ),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       textSelectionTheme: const TextSelectionThemeData(
//         cursorColor: surface1,
//         selectionHandleColor: Colors.transparent,
//         selectionColor: surface1,
//       ),
//       highlightColor: shift(accent1, .1),
//       checkboxTheme: CheckboxThemeData(
//         fillColor:
//             WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
//           if (states.contains(WidgetState.disabled)) {
//             return null;
//           }
//           if (states.contains(WidgetState.selected)) {
//             return accent1;
//           }
//           return null;
//         }),
//       ),
//       radioTheme: RadioThemeData(
//         fillColor:
//             WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
//           if (states.contains(WidgetState.disabled)) {
//             return null;
//           }
//           if (states.contains(WidgetState.selected)) {
//             return accent1;
//           }
//           return null;
//         }),
//       ),
//       switchTheme: SwitchThemeData(
//         thumbColor:
//             WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
//           if (states.contains(WidgetState.disabled)) {
//             return null;
//           }
//           if (states.contains(WidgetState.selected)) {
//             return accent1;
//           }
//           return null;
//         }),
//         trackColor:
//             WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
//           if (states.contains(WidgetState.disabled)) {
//             return null;
//           }
//           if (states.contains(WidgetState.selected)) {
//             return accent1;
//           }
//           return null;
//         }),
//       ));
//   // All done, return the ThemeData

//   return t;
// }
