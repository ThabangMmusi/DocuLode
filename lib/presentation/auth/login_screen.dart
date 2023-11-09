import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../_utils/device_info.dart';
import '../../_utils/logger.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_text.dart';
import '../../routes/app_pages.dart';
import '../../services/firebase/firebase_service.dart';
import '/cubits/cubits.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.isDesktopAuth = false});
  final bool isDesktopAuth;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, authState) {
        return Scaffold(
          backgroundColor: tWhiteColor,
          body: authState.status == AuthStatus.authenticating ||
                  authState.status == AuthStatus.authenticated ||
                  authState.status == AuthStatus.unknown
              ? const Center(child: AuthHeaderWidget())
              : BlocProvider(
                  create: (_) => LoginCubit(context.read<FirebaseService>()),
                  child: LoginForm(
                    isDesktopAuth: isDesktopAuth,
                  ),
                ),
        );
      },
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.isDesktopAuth});
  final bool isDesktopAuth;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {}
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AuthHeaderWidget(),
            kVSpacingHalf,
            kVSpacingDefault,
            kVSpacingDefault,
            _LoginButton(
              isDesktopAuth: isDesktopAuth,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   "assets/logos/logo.png", // replace with the actual path and name of your image file
        //   fit: BoxFit.cover,
        // ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          tAppName,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: tPrimaryColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Text(
          tAppSlogan,
          textAlign: TextAlign.start,
          style: TextStyle(color: tDarkColor.withOpacity(.5), fontSize: 14),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.isDesktopAuth});
  final bool isDesktopAuth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
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
                padding:
                    const EdgeInsets.symmetric(horizontal: kPaddingDefault),
                decoration: BoxDecoration(
                  color: tPrimaryColor,
                  borderRadius: BorderRadius.circular(kPaddingHalf),
                ),
                child: InkWell(
                    onTap: () async {
                      if (DeviceOS.isMobileOrWeb) {
                        context
                            .read<LoginCubit>()
                            .logInWithCredentials(isDesktopAuth);
                      } else {
                        GoRouter.of(context).go(Routes.awaitingWebAuth);
                        var _url =
                            Uri.parse("http://localhost:23429/auth/web-auth");
                        if (!await launchUrl(_url)) {
                          log("Could not launch");
                          throw Exception('Could not launch $_url');
                        }
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.logo_microsoft,
                          color: tWhiteColor,
                        ),
                        kHSpacingHalf,
                        Text(
                          tSignInWithMicrosoft,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: tWhiteColor, fontSize: 17),
                        ),
                      ],
                    )),
              );
      },
    );
  }
}
