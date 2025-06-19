import 'package:doculode/app_bootstrapper.dart';
import 'package:doculode/core/data/models/src/app_model.dart';
import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/features/azure_sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doculode/config/index.dart';
import 'package:doculode/features/profile_setup/presentation/bloc/profile_setup_bloc.dart';
import 'package:doculode/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:doculode/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:doculode/features/shared/presentation/bloc/shared_bloc.dart';
import 'package:doculode/features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'package:doculode/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';
import 'package:doculode/features/uploads/presentation/bloc/uploads_bloc.dart';
import 'package:doculode/core/common/auth/presentation/bloc/auth_bloc.dart';
// import 'features/sign_in/presentation/bloc/bloc.dart';

class App extends StatelessWidget {
  final List<String> args;
  const App({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => sl<AppModel>()),
        RepositoryProvider(create: (context) => sl<DatabaseService>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthBloc>()),
          BlocProvider(create: (context) => sl<ProfileSetupBloc>()),
          BlocProvider(create: (context) => sl<SignInBloc>()),
          BlocProvider(create: (context) => sl<UploadProgressBloc>()),
          BlocProvider(create: (context) => sl<UploadsBloc>()),
          BlocProvider(create: (context) => sl<UploadEditBloc>()),
          BlocProvider(create: (context) => sl<SetupBloc>()),
          BlocProvider(create: (context) => sl<SettingsBloc>()),
          BlocProvider(create: (context) => sl<SharedBloc>()),
        ],
        child: AppBootStrapper(args: args),
      ),
    );
  }
}
