import '../../../../core/domain/entities/entities.dart';
import '../../../../core/common/settings/presentation/bloc/base_settings_bloc.dart';

part 'setup_state.dart';
part 'setup_events.dart';

class SetupBloc extends BaseSettingsBloc<SetupState> {
  SetupBloc({
    required super.getAllCourses,
    required super.getSortedModules,
    required super.updateUserEdu,
    required super.validateEmail,
    required super.validateName,
    required super.updateProfile,
    required super.signOut,
    super.initialState = const SetupState(),
  }) {
    on<SetUpSwitchToPersonalDetail>((event, emit) {
      emit(state.copyWith(formType: SetupType.personal));
    });
    on<SetUpSwitchToAcademics>((event, emit) {
      emit(state.copyWith(formType: SetupType.academics));
    });
    on<ShowSuccessMessage>((event, emit) {
      emit(state.copyWith(status: SettingsStatus.done));
    });
  }
}
