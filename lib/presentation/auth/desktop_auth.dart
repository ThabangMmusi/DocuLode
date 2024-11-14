import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:its_shared/_utils/logger.dart';
import 'package:protocol_handler/protocol_handler.dart';

import '../../commands/app/signin_with_token_command.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../styles.dart';
import '../app_logo.dart';

class DesktopAuthScreen extends StatefulWidget {
  const DesktopAuthScreen({super.key});

  @override
  State<DesktopAuthScreen> createState() => _DesktopAuthScreenState();
}

class _DesktopAuthScreenState extends State<DesktopAuthScreen>
    with ProtocolListener {
  @override
  void initState() {
    protocolHandler.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    protocolHandler.removeListener(this);
    super.dispose();
  }

  @override
  Future<void> onProtocolUrlReceived(String url) async {
    // setState(() {
    await SignInWithTokenCommand().finishUp(url);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhiteColor,
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(kPaddingDefault * 2),
              decoration: BoxDecoration(
                color: tWhiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogoWidget(),
                  Text(
                    "Login using browser",
                    style: TextStyles.h1,
                  ),
                  kVSpacingDefault,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyles.h3,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Not seeing the browser tab?\n",
                          style: TextStyles.h3.copyWith(color: Colors.black45),
                        ),
                        TextSpan(
                            text: 'Try Again',
                            style: TextStyles.h3.copyWith(color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                log('trying again');
                              }),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
