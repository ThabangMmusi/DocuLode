import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../../../core/common/settings/domain/usecases/usecases.dart';
import '../../../../core/common/settings/presentation/bloc/base_settings_bloc.dart';
import '../../../../core/domain/usecases/get_current_user.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/usecases.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends BaseSettingsBloc<SettingsState> {
  final UpdateProfile _updateProfile;
  final GetCurrentUser _getCurrentUser;

  SettingsBloc({
    required super.getAllCourses,
    required super.getSortedModules,
    required super.updateUserEdu,
    required UpdateProfile updateProfile,
    required GetCurrentUser getCurrentUser,
    super.initialState = const SettingsState(),
  })  : _getCurrentUser = getCurrentUser,
        _updateProfile = updateProfile {
    on<SettingsProfileUpdate>(_onProfileUpdate);
    //   on<SettingsAppearanceUpdate>(_onAppearanceUpdate);
    //   on<SettingsPreferencesUpdate>(_onPreferencesUpdate);
    //   on<SettingsAccountDelete>(_onAccountDelete);
    on<SettingsInitialize>(_onInitialize);
  }

  // void _loading(Emitter<SettingsState> emit) {
  //   emit(state.copyWith(status: SettingsStatus.loading));
  // }

  // void _error(Emitter<SettingsState> emit, String message) {
  //   emit(
  //     state.copyWith(status: SettingsStatus.failure, errorMsg: message),
  //   );
  // }

  Future<void> _onInitialize(
    SettingsInitialize event,
    Emitter<SettingsState> emit,
  ) async {
    final getUser = await _getCurrentUser(NoParams());
    final user = getUser.fold(
      (l) {
        error(emit, l.message);
        return null;
      },
      (r) => r,
    );

    if (user == null) {
      error(emit, "User not found");
      return;
    }

    final getCourses = await getAllCourses(NoParams());
    final courses = getCourses.fold(
      (l) {
        error(emit, l.message);
        return null;
      },
      (r) => r,
    );

    if (state.status == SettingsStatus.error) return;

    final getModules = await getSortedModules(CourseModulesParams(
      courseId: user.course!.id,
      maxLevel: user.level!,
    ));

    getModules.fold(
      (l) => error(emit, l.message),
      (r) {
        final modules =
            r.where((m) => user.modules!.any((um) => um.id == m.id)).toList();

        emit(state.copyWith(
          firstNames: user.names,
          lastName: user.surname,
          email: user.email,
          // theme: user.settings?.theme ?? 'Light theme',
          // showRecentLists: user.settings?.showRecentLists ?? true,
          // enableSounds: user.settings?.enableSounds ?? true,
          selectedCourse: user.course!,
          selectedLevel: user.level,
          selectedModules: modules,
          courses: courses,
          modules: r,
          status: SettingsStatus.success,
        ));
      },
    );
  }

  Future<void> _onProfileUpdate(
    SettingsProfileUpdate event,
    Emitter<SettingsState> emit,
  ) async {
    add(LoadingEvent());
    final res = await _updateProfile(ProfileParams(
      names: event.names,
      surname: event.surname,
    ));

    res.fold(
      (l) => error(emit, l.message),
      (r) {
        // final user = currrentUser;
        // super._authBloc.add(AuthUserChanged(
        //       user: user.copyWith(
        //         names: event.names,
        //         surname: event.surname,
        //       ),
        //     ));
        emit(state.copyWith(
          status: SettingsStatus.success,
          firstNames: event.names,
          lastName: event.surname,
          email: event.email,
        ));
      },
    );
  }

  // Future<void> _onAppearanceUpdate(
  //   SettingsAppearanceUpdate event,
  //   Emitter<SettingsState> emit,
  // ) async {
  //   _loading(emit);
  //   final res = await _updateAppearance(AppearanceParams(
  //     theme: event.theme,
  //   ));

  //   res.fold(
  //     (l) => _error(emit, l.message),
  //     (r) {
  //       final user = _authBloc.state.user!;
  //       final settings = user.settings?.copyWith(theme: event.theme) ?? UserSettings(theme: event.theme);
  //       _authBloc.add(AuthUserChanged(
  //         user: user.copyWith(settings: settings),
  //       ));
  //       emit(state.copyWith(
  //         status: SettingsStatus.success,
  //         theme: event.theme,
  //       ));
  //     },
  //   );
  // }

  // Future<void> _onPreferencesUpdate(
  //   SettingsPreferencesUpdate event,
  //   Emitter<SettingsState> emit,
  // ) async {
  //   _loading(emit);
  //   final res = await _updatePreferences(PreferencesParams(
  //     showRecentLists: event.showRecentLists,
  //     enableSounds: event.enableSounds,
  //   ));

  //   res.fold(
  //     (l) => _error(emit, l.message),
  //     (r) {
  //       final user = _authBloc.state.user!;
  //       final settings = user.settings?.copyWith(
  //             showRecentLists: event.showRecentLists,
  //             enableSounds: event.enableSounds,
  //           ) ??
  //           UserSettings(
  //             showRecentLists: event.showRecentLists,
  //             enableSounds: event.enableSounds,
  //           );
  //       _authBloc.add(AuthUserChanged(
  //         user: user.copyWith(settings: settings),
  //       ));
  //       emit(state.copyWith(
  //         status: SettingsStatus.success,
  //         showRecentLists: event.showRecentLists,
  //         enableSounds: event.enableSounds,
  //       ));
  //     },
  //   );
  // }

  // Future<void> _onAccountDelete(
  //   SettingsAccountDelete event,
  //   Emitter<SettingsState> emit,
  // ) async {
  //   emit(state.copyWith(status: SettingsStatus.deleting));
  //   final res = await _deleteAccount(NoParams());

  //   res.fold(
  //     (l) => _error(emit, l.message),
  //     (r) {
  //       _authBloc.add(AuthLogoutRequested());
  //       emit(state.copyWith(status: SettingsStatus.deleted));
  //     },
  //   );
  // }
}
