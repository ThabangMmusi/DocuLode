import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:its_shared/bloc/auth/auth_bloc.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_text.dart';
import '../../routes/app_pages.dart';
import '../../styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          context.go(Routes.signIn);
        } else if (state.status == AuthStatus.authenticated) {
          context.go(Routes.home);
        }
      },
      child: Scaffold(
        body: _buildLogo2(context),
      ),
    );
  }

  Widget _buildLogo2(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kPaddingDefault * 2.25),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            tAppName,
            style: TextStyles.h2
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            tAppVersion,
            style: TextStyles.body2.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w300),
          ),
        ]),
      ),
    );
  }
}
