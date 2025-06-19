import 'package:doculode/config/index.dart';
import 'package:doculode/core/commands/app/index.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/app.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  initLogger(() async {
    log("main: Starting application initialization");
    log("main: Initializing Flutter binding");
    WidgetsFlutterBinding.ensureInitialized();

    log("main: Running BootstrapCommand");
    // Bootstrap. This will initialize services, load saved data, determine initial navigation state and anything else that needs to get done at startup
    await BootstrapCommand().run();

    log("main: Initializing dependencies");
    await initDependencies();

    log("main: Setting up app with providers");
    runApp(App(args: args));
  });
}
