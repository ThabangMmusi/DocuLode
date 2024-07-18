import 'package:flutter/material.dart';

import 'styles.dart';

class AppTheme {
  static Color greenSurface = const Color(0xFF2C8769);
  static Color blueSurface = const Color(0xFF0061FE);
  static Color greenSurfaceDark = const Color(0xFF206F54);
  static Color blueSurfaceDark = const Color(0xFF004BC2);
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

  static Color accentColor = const Color(0xffff392b);
  static ThemeData get light {
    ColorScheme colorScheme = ColorScheme.fromSwatch(
      primarySwatch: getMaterialColor(accentColor),
      // accentColor: const Color(0xffff392b),
      // cardColor: const Color(0XFFFAFAFA),
      backgroundColor: const Color(0XFFFAFAFA),
      // secondary: const Color(0XFFE8E8E8),
    );
    Color dividerColor = const Color(0XFFE8E8E8);
    BorderSide dInputBS = BorderSide(color: colorScheme.primary);
    return ThemeData(
      // useMaterial3: false,
      // appBarTheme: const AppBarTheme(color: Colors.white),
      colorScheme: colorScheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: DividerThemeData(
          color: dividerColor, thickness: 1, space: Insets.med * 2),
      searchBarTheme: SearchBarThemeData(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(colorScheme.background),
        // side:WidgetStateProperty.all(dInputBS),
        // shape:WidgetStateProperty.all(RoundedRectangleBorder(
        //     side: dInputBS, borderRadius: Corners.medBorder))
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.background,
        contentPadding:
            EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.lg),
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            gapPadding: 0,
            borderRadius: Corners.medBorder),
        focusedBorder: OutlineInputBorder(
            borderSide: dInputBS,
            gapPadding: 0,
            borderRadius: Corners.medBorder),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(Insets.med)),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.sm))),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(Insets.med)),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.sm))),
      )),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(Insets.med)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.sm))),
      )),
      switchTheme: SwitchThemeData(
          splashRadius: 0,
          thumbColor: WidgetStateProperty.all(colorScheme.onSecondary),
          trackColor: WidgetStateProperty.all(dividerColor),
          // trackOutlineWidth:  MaterialStateProperty.resolveWith(0),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent)),
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
