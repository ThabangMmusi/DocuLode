import 'dart:convert';

import 'package:doculode/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:doculode/core/utils/logger.dart';

import '../../../utils/debouncer.dart';
import '../../../utils/device_info.dart';
import '../../../utils/universal_file/universal_file.dart';
import 'app_user/app_user.dart';

// abstract class AbstractModel extends EasyNotifier {}

// * Make sure file is cleared when we logout (ChangeUserCommand)
class AppModel {
  static const kFileName = "app-model";
  String get kVersion => tAppVersion;

  // Determines what the start value should be for touchMode, bases on the current device os
  static bool defaultToTouchMode() => DeviceOS.isMobile;

  AppModel() {
    //_booksModel.addListener(notify);
  }

  // State
  final Debouncer _saveDebouncer = Debouncer(const Duration(seconds: 1));

  /// Touch Mode (show buttons instead of using right-click, use larger paddings)
  bool _enableTouchMode = defaultToTouchMode();
  bool get enableTouchMode => _enableTouchMode;
  set enableTouchMode(bool value) {
    if (value == _enableTouchMode) return;
    scheduleSave();
    // notify(() => _enableTouchMode = value);
  }

  void reset() {
    currentUser = null;
    enableTouchMode = defaultToTouchMode();
  }

  /// Startup
  bool hasBootstrapped = false;

  /// Auth
  // Current User
  AppUser? currentUser;

  bool get hasUser => currentUser != null;
  bool get isAuthenticated => hasUser;

  // TextDirection
  final TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection;
  // set textDirection(TextDirection value) =>
  //     notify(() => _textDirection = value);

  // Window Position
  Size windowSize = Size.zero;

  void scheduleSave() => _saveDebouncer.run(save);

  Future<void> save() async {
    log("Saving: $kFileName");
    String saveJson = jsonEncode(toJson());
    await UniversalFile(kFileName).write(saveJson);
    log("Done Saving: $kFileName");
  }

  Future<void> load() async {
    String? saveJson = await UniversalFile(AppModel.kFileName).read();
    if (saveJson != null) {
      try {
        fromJson(jsonDecode(saveJson) as Map<String, dynamic>);
        log("Save file loaded, $windowSize");
      } catch (e) {
        log("Failed to decode save file json: $e");
      }
    } else {
      log("No save file found.");
    }
  }

  void fromJson(Map<String, dynamic> json) {
    currentUser = json["currentUser"] != null
        ? AppUser.fromJson(json["currentUser"] as Map<String, dynamic>)
        : null;
    if (json["enableTouchMode"] != null) {
      _enableTouchMode = json["enableTouchMode"] as bool;
    }
    windowSize = Size(
      json["winWidth"] as double? ?? 0.0,
      json["winHeight"] as double? ?? 0.0,
    );
    //log(json);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "currentUser": currentUser?.toJson(),
      "winWidth": windowSize.width,
      "winHeight": windowSize.height,
      "enableTouchMode": enableTouchMode,
    };
  }
}
