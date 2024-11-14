import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:its_shared/core/bloc/auth/auth_bloc.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_text.dart';
import '../../core/core.dart';
import '../../routes/app_pages.dart';
import '../../styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.loggedOff) {
          context.go(Routes.signIn);
        } else if (state.status == AuthStatus.loggedIn) {
          context.go(Routes.home);
        }
      },
      child: const Scaffold(
        body: Center(
          child: FullAppLogo(),
        ),
      ),
    );
  }
}
