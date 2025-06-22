import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var logHistory = _Dispatcher("");

void _log(String? value, {Color? color}) {
  String v = value ?? "";
  logHistory.value = "$v\n${logHistory.value}";
  if (kDebugMode) {
    if (color != null) {
      // ANSI escape codes for colored output in terminals
      // This might not work in all IDE consoles, but works in a true terminal.
      print('\x1B[${color.toARGB32()}m$v\x1B[0m');
    } else {
      print(v);
    }
  }
}

void log(String? value) => _log("💡 ${value ?? ""}", color: Colors.blue);

void logSuccess(String? value) => _log("✅ ${value ?? ""}", color: Colors.green);

void logError(String? value) => _log("❌ ${value ?? ""}", color: Colors.red);

// Take from: https://flutter.dev/docs/testing/errors
void initLogger(VoidCallback runApp) {
  runZonedGuarded(() async {
    // WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      logError(details.stack.toString());
    };
    runApp.call();
  }, (Object error, StackTrace stack) {
    logError(stack.toString());
  });
}

class _Dispatcher extends ValueNotifier<String> {
  _Dispatcher(super.value);
}
