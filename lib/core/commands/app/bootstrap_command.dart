import 'package:doculode/config/index.dart';
import 'package:doculode/core/data/models/src/app_model.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/core/utils/time_utils.dart';
import 'package:doculode/core/utils/device_info.dart';
import 'package:doculode/core/utils/native_window_utils/window_utils.dart';
import 'package:doculode/core/constants/app_text.dart';
import 'dart:math';

// import 'package:desktop_window/desktop_window.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:system_info_plus/system_info_plus.dart';

class BootstrapCommand {
  static int kMinBootstrapTimeMs = 0;

  late AppModel appModel;
  Future<void> run() async {
    int startTime = TimeUtils.nowMillis;
    log("Bootstrap Started, v$tAppVersion");
    log("BootstrapCommand - Registering AppModel");
    sl.registerLazySingleton(() => AppModel());
    appModel = sl<AppModel>();

    log("BootstrapCommand - Loading AppModel");
    await appModel.load();
    log("BootstrapCommand - AppModel loaded successfully");
    // log("BootstrapCommand - AppModel Loaded, user = ${appModel.currentUser}");
    // Set the cacheSize so we'll use more RAM on desktop and higher spec devices.
    log("BootstrapCommand - Configure memory cache");
    _configureMemoryCache();

    // Once model is loaded, we can configure the desktop.
    if (DeviceOS.isDesktop) {
      log("BootstrapCommand - Configure desktop");
      _configureDesktop();
    }

    // For aesthetics, we'll keep splash screen up for some min-time (skip on web)
    if (kIsWeb == false) {
      int remaining = kMinBootstrapTimeMs - (TimeUtils.nowMillis - startTime);
      if (remaining > 0) {
        log("BootstrapCommand - waiting for $remaining ms");
        await Future<void>.delayed(Duration(milliseconds: remaining));
      }
    }
    log("BootstrapCommand - Complete");
  }

  Future<void> _configureMemoryCache() async {
    log("BootstrapCommand - Starting memory cache configuration");
    // Use more memory by default on desktop
    int cacheSize = (DeviceOS.isDesktop ? 2048 : 512) << 20;
    log("BootstrapCommand - Initial cache size: ${cacheSize >> 20}MB");

    if (DeviceOS.isDesktop) {
      try {
        final physicalMemory = await SystemInfoPlus.physicalMemory;
        log("BootstrapCommand - System physical memory: ${physicalMemory! >> 20}MB");
        cacheSize = max(cacheSize, (physicalMemory / 4).round());
        log("BootstrapCommand - Adjusted cache size: ${cacheSize >> 20}MB");
      } on Exception catch (e) {
        log("BootstrapCommand - Error reading physical memory: $e");
      }
    }
    imageCache.maximumSizeBytes = cacheSize;
    log("BootstrapCommand - Memory cache size set to ${cacheSize >> 20}MB");
  }

  void _configureDesktop() async {
    log("BootstrapCommand - Checking single instance");
    if (!await FlutterSingleInstance().isFirstInstance()) {
      log("BootstrapCommand - App instance already running");
      final err = await FlutterSingleInstance().focus();
      if (err != null) {
        log("BootstrapCommand - Error focusing existing instance: $err");
      }
      return;
    }
    log("BootstrapCommand - This is the first instance");
    log("BootstrapCommand - Configuring window settings");
    IoUtils.instance.showWindowWhenReady();

    if (!DeviceOS.isMacOS) {
      log("BootstrapCommand - Registering protocol handler for non-MacOS platform");
      await protocolHandler.register(tAppName.toLowerCase());
      IoUtils.instance.setTitle("$tAppName - Desktop");
    }

    Size minSize = const Size(600, 700);
    // if (kDebugMode) minSize = const Size(400, 400);
    // log("BootstrapCommand - Setting minimum window size to ${minSize.width}x${minSize.height}");
    // DesktopWindow.setMinWindowSize(minSize);

    // if (appModel.windowSize.shortestSide > 0) {
    //   log("BootstrapCommand - Setting window size to ${appModel.windowSize.width}x${appModel.windowSize.height}");
    //   DesktopWindow.setWindowSize(appModel.windowSize);
    // }
    // appWindow.show();
    // doWhenWindowReady(() {
    //   final win = appWindow;
    //   win.title = "$tAppName - Desktop";
    //   win.show();
    // });
    windowManager.focus();
  }
}
