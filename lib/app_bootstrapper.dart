import 'package:doculode/features/azure_sign_in/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:doculode/routes/app_pages.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/core/data/models/src/app_model.dart';
import 'package:doculode/config/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:doculode/core/utils/logger.dart';

import 'core/constants/app_text.dart';

class AppBootStrapper extends StatefulWidget {
  final List<String> args;
  const AppBootStrapper({super.key, required this.args});

  @override
  State<AppBootStrapper> createState() => _AppBootStrapperState();
}

class _AppBootStrapperState extends State<AppBootStrapper>
    with ProtocolListener {
  @override
  void initState() {
    log("AppBootStrapperState: initializing state");
    super.initState();
    protocolHandler.addListener(this);
    log("AppBootStrapperState: protocol handler listener added");
  }

  @override
  void dispose() {
    log("AppBootStrapperState: disposing");
    protocolHandler.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("AppBootStrapperState: building app");
    bool enableTouchMode = context.select((AppModel m) => m.enableTouchMode);
    log("AppBootStrapperState: touch mode enabled = $enableTouchMode");

    return MaterialApp.router(
      title: "SPU Share",
      debugShowCheckedModeBanner: false,
      routerConfig:
          AppRouter(dataService: context.read<DatabaseService>()).router,
      theme: AppTheme.light,
    );
  }
   @override
  void onProtocolUrlReceived(String url) {
    if(url.contains(tVerifyEmailProtocol)) {
      context.read<SignInBloc>().add(MagicLinkVerificationSubmitted());
    }
  }
}
