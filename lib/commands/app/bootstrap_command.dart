import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import '../../_utils/device_info.dart';
import '../../_utils/logger.dart';
import '../../_utils/native_window_utils/window_utils.dart';
import '../../_utils/time_utils.dart';
import '../../core/common/auth/presentation/bloc/auth_bloc.dart';
import '../commands.dart';
import 'signin_with_token_command.dart';

class BootstrapCommand extends BaseAppCommand {
  static int kMinBootstrapTimeMs = 2000;

  Future<void> run(BuildContext context, List<String> args) async {
    int startTime = TimeUtils.nowMillis;
    if (hasContext == false) {
      setContext(context);
    }
    // log(object)
    log("Bootstrap Started, v${appModel.kVersion}");
    // log(object)
    // Load AppModel ASAP
    await appModel.load();
    log("BootstrapCommand - AppModel Loaded, user = ${appModel.currentUser}");
    if (firebase.isSignedIn == false && appModel.currentUser != null) {
      // If we previously has a user, it's unexpected that firebase has lost auth. Give it some extra time.
      await Future<void>.delayed(const Duration(seconds: 1));
      // See if we don't have auth now...
      if (firebase.isSignedIn == false) {
        //Still no auth, clear the stale user data.
        //TODO: Can we try some sort of re-auth here instead of just bailing
        appModel.currentUser = null;
      }
    }

    // log("BootstrapCommand - Init Cloud Storage");
    // Init services
    // cloudStorage.init();
    // Set the cacheSize so we'll use more RAM on desktop and higher spec devices.
    // log("BootstrapCommand - Configure memory cache");
    // _configureMemoryCache();

    // Once model is loaded, we can configure the desktop.
    if (DeviceOS.isDesktop) {
      log("BootstrapCommand - Configure desktop");
      _configureDesktop(args);
    }
    // Login?
    // if (appModel.currentUser != null) {
    //   log("BootstrapCommand - Set current user");
    //   //helps un to get the access code as well as the refresh code
    //   if (DeviceOS.isWindows) {
    //     firebase.seCurrentUser = appModel.currentUser;
    //     await firebase.signInWithMicrosoft(true);
    //   } else {
    //     // firebase.streamUserChange();
    //   }
    //   // await SetCurrentUserCommand().run(appModel.currentUser);
    //   // log("BootstrapCommand - Refresh books");
    //   // RefreshAllBooks();
    // } else {
    //   firebase.streamUserChange();
    // }
    // For aesthetics, we'll keep splash screen up for some min-time (skip on web)
    if (kIsWeb == false) {
      int remaining = kMinBootstrapTimeMs - (TimeUtils.nowMillis - startTime);
      if (remaining > 0) {
        log("BootstrapCommand - waiting for $remaining ms");
        await Future<void>.delayed(Duration(milliseconds: remaining));
      }
    }
    appModel.hasBootstrapped = true;
    log("BootstrapCommand - Complete");
    // firebase.streamUserChange();
  }

  void notifyAuthListener() {
    mainContext.read<AuthBloc>().add(const AuthUserChanged());
  }
  // void _configureMemoryCache() {
  //   // Use more memory by default on desktop
  //   int cacheSize = (DeviceOS.isDesktop ? 2048 : 512) << 20;
  //   // If we're on a native platform, reserve some reasonable amt of RAM
  //   if (DeviceOS.isDesktop) {
  //     try {
  //       // Use some percentage of system ram, but don't fall below the default, in case this returns 0 or some other invalid value.
  //       cacheSize = max(cacheSize, (SysInfo.getTotalPhysicalMemory() / 4).round());
  //     } on Exception catch (e) {
  //       log(e.toString());
  //     }
  //   }
  //   imageCache.maximumSizeBytes = cacheSize;
  // }

  void _configureDesktop(List<String> args) async {
    // if (DeviceOS.isWindows) {
    await WindowsSingleInstance.ensureSingleInstance(args, "itsshared_instance",
        onSecondWindow: (args) async {
      //sometimes the protocol does not work
      ///so use this
      SignInWithTokenCommand().start(args[0]);
      log(args.toString());
    });
    // }
    /// Polish (for Windows OS), to hide any movement of the window on startup.
    IoUtils.instance.showWindowWhenReady();
    if (!DeviceOS.isMacOS) {
      IoUtils.instance.setTitle("Its Shared");
    }
    Size minSize = const Size(600, 700);
    if (kDebugMode) minSize = const Size(400, 400);
    DesktopWindow.setMinWindowSize(minSize);
    if (appModel.windowSize.shortestSide > 0) {
      DesktopWindow.setWindowSize(appModel.windowSize);
    }

    await protocolHandler.register("itsshared");
  }
}
