import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import '_utils/device_info.dart';
import '_utils/logger.dart';
import 'bloc/auth/auth_bloc.dart';
import 'commands/app/bootstrap_command.dart';
import 'commands/app/signin_with_token_command.dart';
import 'constants/app_colors.dart';
import 'models/app_model.dart';
import 'repositories/courses/courses_repository.dart';
import 'repositories/user/user_repository.dart';
import 'routes/app_pages.dart';
import 'services/firebase/firebase_service.dart';
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
    if (DeviceOS.isWindows) {
      await WindowsSingleInstance.ensureSingleInstance(
          args, "itsshared_instance", onSecondWindow: (args) async {
        //sometimes the protocol does not work
        ///so use this
        await SignInWithTokenCommand().run(args[0]);
        log(args.toString());
      });
    }
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseService firebase = FirebaseFactory.create();
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AppModel(),
        ),
        RepositoryProvider(
          create: (context) => firebase,
        ),
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
        ],
        child: const AppBootStrapper(),
      ),
    );
  }
}

// Bootstrap the app, initializing all Controllers and Services
class AppBootStrapper extends StatefulWidget {
  const AppBootStrapper({super.key});

  @override
  State<AppBootStrapper> createState() => _AppBootStrapperState();
}

class _AppBootStrapperState extends State<AppBootStrapper> {
  @override
  void initState() {
    // Run Bootstrap with scheduleMicrotask to avoid triggering any builds from init(), which would throw an error.
    scheduleMicrotask(() {
      // Bootstrap. This will initialize services, load saved data, determine initial navigation state and anything else that needs to get done at startup
      BootstrapCommand().run(context);
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
    ThemeData materialTheme =
        AppTheme.fromType(ThemeType.Orange_Light).toThemeData();
    // Determine the density we want, based on AppModel.enableTouchMode
    bool enableTouchMode = context.select((AppModel m) => m.enableTouchMode);
    double density = enableTouchMode ? 0 : -1;
    print("enableTouchMode: $enableTouchMode");
    // Inject desired density into MaterialTheme for free animation when values change
    materialTheme = ThemeData(
        visualDensity: VisualDensity(horizontal: density, vertical: density));
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
}

ThemeData toThemeData({bool isDark = false}) {
  const Color bg1 = Color(0xffF3F3F3);
  const Color surface1 = Colors.white;
  const Color surface2 = Color.fromARGB(255, 21, 23, 24);
  const Color accent1 = Color(0xffff392b);
  const Color greyWeak = Color(0xffcccccc);
  const Color grey = Color(0xff999999);
  const Color greyMedium = Color(0xff747474);
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

  var t = ThemeData.from(
    // Use the .dark() and .light() constructors to handle the text themes
    // textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
    // Use ColorScheme to generate the bulk of the color theme
    useMaterial3: true,
    colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: accent1,
        primaryContainer: shift(accent1, .1),
        secondary: accent1,
        secondaryContainer: shift(accent1, .1),
        background: bg1,
        surface: surface1,
        onBackground: mainTextColor,
        onSurface: mainTextColor,
        onError: mainTextColor,
        onPrimary: inverseTextColor,
        onSecondary: inverseTextColor,
        inverseSurface: surface2,
        tertiary: greyWeak,
        error: focus),
  );
  // Apply additional styling that is missed by ColorScheme
  t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
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
