import 'dart:convert';

import 'package:flutter/material.dart';

import '../_utils/debouncer.dart';
import '../_utils/device_info.dart';
import '../_utils/universal_file/universal_file.dart';
import 'app_user/app_user.dart';

// abstract class AbstractModel extends EasyNotifier {}

// * Make sure file is cleared when we logout (ChangeUserCommand)
class AppModel {
  static const kFileName = "app-model";
  String get kVersion => "1.0.0";

  // Determines what the start value should be for touchMode, bases on the current device os
  static bool defaultToTouchMode() => DeviceOS.isMobile;

  AppModel() {
    //_booksModel.addListener(notify);
  }

  // State
  final Debouncer _saveDebouncer = Debouncer(const Duration(seconds: 1));

  /// Touch Mode (show btns instead of using right-click, use larger paddings)
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
  bool _hasBootstrapped = false;
  bool get hasBootstrapped => _hasBootstrapped;
  set hasBootstrapped(bool value) => _hasBootstrapped = value;

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
    print("Saving: $kFileName");
    String saveJson = jsonEncode(toJson());
    await UniversalFile(kFileName).write(saveJson);
    print("Done Saving: $kFileName");
  }

  Future<void> load() async {
    String? saveJson = await UniversalFile(AppModel.kFileName).read();
    if (saveJson != null) {
      try {
        fromJson(jsonDecode(saveJson) as Map<String, dynamic>);
        print("Save file loaded, $windowSize");
      } catch (e) {
        print("Failed to decode save file json: $e");
      }
    } else {
      print("No save file found.");
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
    //print(json);
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
