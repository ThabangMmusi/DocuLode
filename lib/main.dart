import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_shared/features/settings/presentation/bloc/settings_bloc.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:its_shared/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:its_shared/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:its_shared/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';
import 'package:its_shared/features/uploads/presentation/bloc/uploads_bloc.dart';
import 'package:its_shared/themes.dart';

import '_utils/logger.dart';
import 'core/common/auth/presentation/bloc/auth_bloc.dart';
import 'commands/app/bootstrap_command.dart';
import 'cubits/desktop_auth/desktop_auth_cubit.dart';
import 'features/shared/presentation/bloc/shared_bloc.dart';
import 'injection_container.dart';
import 'core/data/models/src/app_model.dart';
import 'routes/app_pages.dart';
import 'services/firebase/firebase_service.dart';

void main(List<String> args) async {
  initLogger(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDependencies();
    //remove # on the URL
    // setUrlStrategy(PathUrlStrategy());
    // Status bar style on Android/iOS
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarBrightness: Brightness.dark,
    //     statusBarColor: tWhiteColor,
    //     statusBarIconBrightness: Brightness.dark,
    //     systemNavigationBarColor: tWhiteColor,
    //     // systemNavigationBarDividerColor: Colors.white,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );

    // final FirebaseService firebase = FirebaseFactory.create();
    runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => serviceLocator<AppModel>(),
        ),
        // RepositoryProvider(
        //   create: (context) => firebase,
        // ),
        RepositoryProvider(
            create: (context) => serviceLocator<FirebaseService>()),
        // RepositoryProvider(create: (context) => CloudStorageService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => serviceLocator<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => DesktopAuthCubit(),
          ),
          BlocProvider(
            create: (context) => serviceLocator<UploadProgressBloc>(),
          ),
          BlocProvider(
            create: (context) => serviceLocator<UploadsBloc>(),
          ),
          BlocProvider(create: (context) => serviceLocator<UploadEditBloc>()),
          BlocProvider(create: (context) => serviceLocator<SetupBloc>()),
          BlocProvider(create: (context) => serviceLocator<SettingsBloc>()),
          BlocProvider(create: (context) => serviceLocator<SharedBloc>()),
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
    // double density = enableTouchMode ? 0 : -1;
    log("enableTouchMode: $enableTouchMode");
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
        // theme: toThemeData(),
        theme: AppTheme.light,
        // themeMode: ThemeMode.light,
      );
    });
  }
}
