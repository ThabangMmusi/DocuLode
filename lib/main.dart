import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/features/upload_progress/data/sources/upload_file_sources.dart';
import 'package:its_shared/features/upload_progress/domain/usecases/upload_file.dart';
import 'package:its_shared/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';
import 'package:its_shared/services/cloudinary/cloud_storage_service.dart';
import 'package:url_strategy/url_strategy.dart';

import '_utils/logger.dart';
import 'bloc/auth/auth_bloc.dart';
import 'commands/app/bootstrap_command.dart';
import 'constants/app_colors.dart';
import 'cubits/desktop_auth/desktop_auth_cubit.dart';
import 'injection_container.dart';
import 'models/app_model.dart';
import 'repositories/courses/courses_repository.dart';
import 'repositories/user/user_repository.dart';
import 'routes/app_pages.dart';
import 'services/firebase/firebase_service.dart';
import 'styles.dart';
import 'themes.dart';

void main(List<String> args) async {
  initLogger(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Status bar style on Android/iOS
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: tWhiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: tWhiteColor,
        // systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    //remove # on the URL
    setPathUrlStrategy();

    await initDependencies();
    // final FirebaseService firebase = FirebaseFactory.create();
    runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AppModel(),
        ),
        // RepositoryProvider(
        //   create: (context) => firebase,
        // ),
        RepositoryProvider(
            create: (context) => serviceLocator<FirebaseService>()),
        // RepositoryProvider(create: (context) => CloudStorageService()),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(create: (context) => CoursesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<FirebaseService>(),
            ),
          ),
          BlocProvider(
            create: (context) => DesktopAuthCubit(),
          ),
          BlocProvider(
            create: (context) => serviceLocator<UploadProgressBloc>(),
          ),
          // BlocProvider(
          //   create: (context) => ConnectionCubit(),
          // )
        ],
        child: AppBootStrapper(args: args),
      ),
    ));
  });
}

// Bootstrap the app, initializing all Controllers and Services
class AppBootStrapper extends StatefulWidget {
  const AppBootStrapper({super.key, required this.args});
  final List<String> args;
  @override
  State<AppBootStrapper> createState() => _AppBootStrapperState();
}

class _AppBootStrapperState extends State<AppBootStrapper> {
  @override
  void initState() {
    // Run Bootstrap with scheduleMicrotask to avoid triggering any builds from init(), which would throw an error.
    scheduleMicrotask(() {
      // Bootstrap. This will initialize services, load saved data, determine initial navigation state and anything else that needs to get done at startup
      BootstrapCommand().run(context, widget.args);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // // Get the current AppTheme so we can generate a ThemeData for the MaterialApp
    // AppTheme theme = context.select((AppModel m) => m.theme);
    // // TODO-SNIPPET: Using visual density
    // // Generate ThemeData from our own custom AppTheme object
    // ThemeData materialTheme = theme.toThemeData();
    // ThemeData materialTheme = EventLinkTheme.light;
    // Determine the density we want, based on AppModel.enableTouchMode
    bool enableTouchMode = context.select((AppModel m) => m.enableTouchMode);
    double density = enableTouchMode ? 0 : -1;
    print("enableTouchMode: $enableTouchMode");
    // Inject desired density into MaterialTheme for free animation when values change
    // materialTheme = ThemeData(
    //     visualDensity: VisualDensity(horizontal: density, vertical: density));
    return Builder(builder: (context) {
      return MaterialApp.router(
        title: "SPU Share",
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter(
                fireService: context.read<FirebaseService>(),
                authBloc: context.read<AuthBloc>())
            .router,
        theme: toThemeData(),
        themeMode: ThemeMode.light,
      );
    });
  }
} //0861111761

ThemeData toThemeData({bool isDark = false}) {
  const Color surface1 = Color(0xffFAFAFA);
  const Color surface2 = Color.fromARGB(55, 21, 23, 24);
  const Color accent1 = Color(0xffff392b);
  const Color accent2 = Color.fromARGB(255, 230, 42, 29);
  const Color greyWeak = Color(0xffcccccc);
  const Color grey = Color(0xff535353);
  const Color greyMedium = Color(0xff787878);
  const Color greyStrong = Color(0xff333333);
  const Color focus = Color(0xffd81e1e);
  Color mainTextColor = isDark ? Colors.white : Colors.black;
  Color inverseTextColor = isDark ? Colors.black : Colors.white;

  /// This will add luminance in dark mode, and remove it in light.
  // Allows the view to just make something "stronger" or "weaker" without worrying what the current theme brightness is
  //      color = theme.shift(someColor, .1); //-10% lum in dark mode, +10% in light mode
  Color shift(Color c, double amt) {
    amt *= (isDark ? -1 : 1);
    var hslc = HSLColor.fromColor(c); // Convert to HSL
    double lightness =
        (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
    return hslc.withLightness(lightness).toColor(); // Convert back to Color
  }

  ThemeData t = ThemeData.from(
    // fontFamily: Fonts.raleway,
    // Use the .dark() and .light() constructors to handle the text themes
    // textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
    // Use ColorScheme to generate the bulk of the color theme
    useMaterial3: false,
    colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
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
        error: focus),
  );

  // Apply additional styling that is missed by ColorScheme
  t.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: Corners.lgBorder,
            borderSide: BorderSide(
                color: greyWeak, width: 1, style: BorderStyle.solid)),
        focusedBorder: OutlineInputBorder(
            borderRadius: Corners.lgBorder,
            borderSide:
                BorderSide(color: accent1, width: 1, style: BorderStyle.solid)),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: surface1,
        selectionHandleColor: Colors.transparent,
        selectionColor: surface1,
      ),
      highlightColor: shift(accent1, .1),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accent1;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accent1;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accent1;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return accent1;
          }
          return null;
        }),
      ));
  // All done, return the ThemeData

  return t;
}
