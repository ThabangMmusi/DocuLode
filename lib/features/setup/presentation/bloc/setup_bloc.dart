import 'package:its_shared/core/common/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../../../core/common/settings/presentation/bloc/base_settings_bloc.dart';

part 'setup_state.dart';

class SetupBloc extends BaseSettingsBloc {
  SetupBloc(
      {required super.getAllCourses,
      required super.getSortedModules,
      required super.updateUserEdu,
      super.initialState = const SetupState(),
  });
}