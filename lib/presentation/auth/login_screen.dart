import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../_utils/device_info.dart';
import '../../core/common/auth/presentation/bloc/auth_bloc.dart';
import '../../commands/app/authenticate_desktop_command.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_text.dart';
import '../../cubits/cubits_enum.dart';
import '../../services/firebase/firebase_service.dart';
import '../../widgets/buttons/styled_buttons.dart';
import '../app_logo.dart';
import '../app_title_bar/app_title_bar.dart';
import '/cubits/cubits.dart';
import 'await_auth_dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.isDesktopAuth = false});
  final bool isDesktopAuth;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, authState) {
        return Scaffold(
          // backgroundColor: tWhiteColor,
          body: Column(
            children: [
              const AppTitleBar(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authState.status == AuthStatus.authenticating ||
                              authState.status == AuthStatus.unknown
                          ? const Center(child: AppLogoWidget())
                          : BlocProvider(
                              create: (_) =>
                                  LoginCubit(context.read<FirebaseService>()),
                              child: LoginForm(
                                isDesktopAuth: isDesktopAuth,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
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
        if (state.status == CubitStatus.error) {}
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogoWidget(),
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

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.isDesktopAuth});
  final bool isDesktopAuth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return PrimaryBtn(
          loading: state.status == CubitStatus.submitting ||
              state.status == CubitStatus.success,
          icon: DeviceOS.isDesktop
              ? Ionicons.open_outline
              : Ionicons.logo_microsoft,
          leadingIcon: !DeviceOS.isDesktop,
          label: DeviceOS.isDesktop ? tLogin : tLogInWithMicrosoft,
          onPressed: () async {
            if (DeviceOS.isMobileOrWeb) {
              context.read<LoginCubit>().logInWithCredentials(isDesktopAuth);
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const AwaitAuthDialog(),
              );
              await AuthenticateDesktopCommand().openLoginTab();
            }
          },
        );
      },
    );
  }
}
