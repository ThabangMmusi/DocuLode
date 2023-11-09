import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:protocol_handler/protocol_handler.dart';

import '../../commands/app/signin_with_token_command.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../styles.dart';
import 'login_screen.dart';

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
    await SignInWithTokenCommand().run(url);
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
                  const AuthHeaderWidget(),
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
                                print('trying again');
                              }),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.loading, required this.title});
  final bool loading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: tDarkColor,
                  backgroundColor: Colors.black12,
                )),
          )
        : Container(
            width: 250,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
            decoration: BoxDecoration(
              color: tPrimaryColor,
              borderRadius: BorderRadius.circular(kPaddingHalf),
            ),
            child: InkWell(
                onTap: () {
                  // context.read<LoginCubit>().logInWithCredentials();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.key,
                      color: tWhiteColor,
                    ),
                    kHSpacingHalf,
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyles.h3.copyWith(color: tWhiteColor),
                    ),
                  ],
                )),
          );
  }
}
