import 'dart:io';

import 'package:doculode/core/constants/app_enums.dart';
import 'package:doculode/core/data/models/models.dart';
import 'package:doculode/core/index.dart';
import 'package:doculode/core/domain/usecases/validate_name_use_case.dart';
import 'package:doculode/core/utils/logger.dart';
import 'package:doculode/features/profile_setup/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:doculode/core/common/auth/domain/usecases/sign_out.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';

enum ProfileSetupOperation {
  idle,
  loadingCourses,
  loadingModules,
  submittingProfile,
  uploadingImage, loadingUserName
}

enum ProfileSetupStep {
  personalDetails,
  academicFoundation,
  moduleSelection,
}

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final GetAvailableCoursesUseCase _getAvailableCourses;
  final GetModulesUseCase _getModules;
  final GetUserNameUseCase _getUserName;
  final SubmitRegistrationUseCase _submitRegistration;
  final UploadProfileImageUseCase _uploadProfileImage;
  final ValidateNameUseCase _validateName;
  final SignOut _signOut;

  ProfileSetupBloc({
    required GetAvailableCoursesUseCase getAvailableCourses,
    required GetModulesUseCase getModules,
    required SubmitRegistrationUseCase submitRegistration,
    required UploadProfileImageUseCase uploadProfileImage,
    required ValidateNameUseCase validateName,
    required GetUserNameUseCase getUserName,
    required SignOut signOut,
  })  : _getAvailableCourses = getAvailableCourses,
        _getModules = getModules,
        _submitRegistration = submitRegistration,
        _uploadProfileImage = uploadProfileImage,
        _validateName = validateName,
        _signOut = signOut,
        _getUserName = getUserName,
        super(ProfileSetupState(
            activeOperation: ProfileSetupOperation.idle,
            operationStatus: OperationStatus.idle)) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<ProfileImageChanged>(_onProfileImageChanged);
    on<ChangeTheStep>(_onChangeTheStep);
    on<GetAllCoursesRequest>(_onGetAllCoursesRequest);
    on<CourseChanged>(_onCourseChanged);
    on<YearChanged>(_onYearChanged);
    on<SelectedYearsChanged>(_onSelectedYearsChanged);
    on<SemesterChanged>(_onSemesterChanged);
    on<LoadModulesRequested>(_onLoadModulesRequested);
    on<ModuleToggled>(_onModuleToggled);
    on<SubmitRegistration>(_onSubmitProfileRequested);
    on<GetUserName>(_onGetUserName);
  }

  Future<void> _onGetUserName(GetUserName event, Emitter<ProfileSetupState> emit) async {
    emit(state.copyWith(
        activeOperation: () => ProfileSetupOperation.loadingUserName,
        operationStatus: () => OperationStatus.inProgress));
    final result = await _getUserName(NoParams());
    result.fold(
        (failure) => emit(state.copyWith(
            activeOperation: () => ProfileSetupOperation.idle,
            operationStatus: () => OperationStatus.failure,
            operationError: () => failure.message)),
        (userName) {
          
          emit(state.copyWith(
            firstName: userName));
          add(const GetAllCoursesRequest());
        });
  }

  void _onChangeTheStep(ChangeTheStep event, Emitter<ProfileSetupState> emit) {
    log('ProfileSetupBloc: Changing step to ${event.targetFlow}');
    if (event.targetFlow == ProfileSetupStep.academicFoundation) {
      emit(state.copyWith(flow: event.targetFlow));
      add(GetAllCoursesRequest());
    } else if (event.targetFlow == ProfileSetupStep.moduleSelection &&
        state.selectedCourse != null &&
        state.selectedYear != null &&
        state.selectedSemester != null) {
      log('ProfileSetupBloc: Loading modules for year ${state.selectedYear} and semester ${state.selectedSemester}');
      add(LoadModulesRequested(
          forYear: state.selectedYear!, forSemester: state.selectedSemester));
      emit(state.copyWith(flow: event.targetFlow));
    } else {
      emit(state.copyWith(flow: event.targetFlow));
    }
  }

  void _onFirstNameChanged(
      FirstNameChanged event, Emitter<ProfileSetupState> emit) async {
    final result = await _validateName(event.firstName);
    result.fold(
        (failure) => emit(state.copyWith(
            firstName: event.firstName, firstNameError: () => failure.message)),
        (validationResult) => emit(state.copyWith(
            firstName: event.firstName, firstNameError: () => null)));
  }

  void _onLastNameChanged(
      LastNameChanged event, Emitter<ProfileSetupState> emit) async {
    final result = await _validateName(event.lastName);
    result.fold(
        (failure) => emit(state.copyWith(
            lastName: event.lastName, lastNameError: () => failure.message)),
        (validationResult) => emit(state.copyWith(
            lastName: event.lastName, lastNameError: () => null)));
  }

  Future<void> _onProfileImageChanged(
      ProfileImageChanged event, Emitter<ProfileSetupState> emit) async {
    if (event.imageFile == null) {
      emit(state.copyWith(
          profileImageFile: () => null, profileImageError: () => null));
      return;
    }
    emit(state.copyWith(
        activeOperation: () => ProfileSetupOperation.uploadingImage,
        operationStatus: () => OperationStatus.inProgress,
        profileImageFile: () => event.imageFile,
        profileImageError: () => null));

    // For now, just update state without actual upload
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate upload
    emit(state.copyWith(
        activeOperation: () => ProfileSetupOperation.idle,
        operationStatus: () => OperationStatus.success));
  }

  Future<void> _onGetAllCoursesRequest(
      GetAllCoursesRequest event,
      Emitter<ProfileSetupState> emit) async {
    try {
      log('ProfileSetupBloc: Loading academic courses');
      emit(state.copyWith(
          activeOperation: () => ProfileSetupOperation.loadingCourses,
          operationStatus: () => OperationStatus.inProgress,
          operationError: () => null));
      final coursesResult = await _getAvailableCourses(NoParams());
      coursesResult.fold(
        (failure) {
          logError(
              'ProfileSetupBloc: Failed to load courses - ${failure.message}');
          emit(state.copyWith(
            activeOperation: () => ProfileSetupOperation.idle,
            operationStatus: () => OperationStatus.failure,
            availableCourses: [],
            operationError: () => "Failed to load courses.",
          ));
        },
        (courses) {
          log('ProfileSetupBloc: Successfully loaded ${courses.length} courses');
          emit(state.copyWith(
            activeOperation: () => ProfileSetupOperation.idle,
            operationStatus: () => OperationStatus.success,
            availableCourses: courses,
            operationError: () => null,
          ));
        },
      );
    } catch (e) {
      logError('ProfileSetupBloc: Exception while loading courses - $e');
      emit(state.copyWith(
          operationStatus: () => OperationStatus.failure,
          operationError: () =>
              "An unexpected error occurred while loading courses."));
    }
  }

  void _onCourseChanged(CourseChanged event, Emitter<ProfileSetupState> emit) {
    log('ProfileSetupBloc: Course changed to ${event.course?.name ?? "null"}');
    emit(state.copyWith(
        selectedCourse: () => event.course,
        selectedCourseError: () => null,
        selectedYear: () => null,
        selectedSemester: () => null,
        availableModulesByYear: {},
        selectedModulesByYear: {}));
  }

  void _onYearChanged(YearChanged event, Emitter<ProfileSetupState> emit) {
    // Get current month (1-12)
    final currentMonth = DateTime.now().month;

    // Determine semester based on month
    // Semester 1: August to December (8-12)
    // Semester 2: January to July (1-7)
    final autoSelectedSemester = currentMonth >= 8 ? 1 : 2;

    log('ProfileSetupBloc: Year changed to ${event.selectedYear}, auto-selecting semester $autoSelectedSemester');

    emit(state.copyWith(
        selectedYear: () => event.selectedYear,
        selectedYearError: () => null,
        selectedSemester: () => autoSelectedSemester,
        availableModulesByYear: {},
        selectedModulesByYear: {}));
  }

  void _onSemesterChanged(
      SemesterChanged event, Emitter<ProfileSetupState> emit) {
    log('ProfileSetupBloc: Semester changed to ${event.semester}');
    emit(state.copyWith(
        selectedSemester: () => event.semester,
        selectedSemesterError: () => null));
  }

  void _onLoadModulesRequested(
      LoadModulesRequested event, Emitter<ProfileSetupState> emit) async {
    if (state.selectedCourse == null ||
        state.selectedYear == null ||
        state.selectedSemester == null) {
      logError(
          'ProfileSetupBloc: Cannot load modules - missing course, year, or semester');
      emit(state.copyWith(
          operationError: () =>
              "Please select a course and year to load modules."));
      return;
    }

    log('ProfileSetupBloc: Loading modules for course ${state.selectedCourse!.name}, year ${event.forYear}, semester ${event.forSemester ?? state.selectedSemester}');

    emit(state.copyWith(
        activeOperation: () => ProfileSetupOperation.loadingModules,
        operationStatus: () => OperationStatus.inProgress,
        operationError: () => null));
    final params = GetModulesParams(
        courseId: state.selectedCourse!.id,
        year: event.forYear,
        semester: event.forSemester ?? state.selectedSemester!);
    final modulesResult = await _getModules(params);
    modulesResult.fold((failure) {
      logError('ProfileSetupBloc: Failed to load modules - ${failure.message}');
      emit(
        state.copyWith(
            operationStatus: () => OperationStatus.failure,
            operationError: () => "Failed to load modules."),
      );
    }, (modules) {
      // Create a new map with the existing modules plus the new ones
      final Map<int, List<ModuleModel>> modulesByYear =
          Map.from(state.availableModulesByYear);
      modulesByYear[event.forYear] = modules;

      log('ProfileSetupBloc: Successfully loaded ${modules.length} modules for year ${event.forYear}');
      log('ProfileSetupBloc: Available modules by year: ${modulesByYear.keys.join(', ')}');

      emit(state.copyWith(
          activeOperation: () => ProfileSetupOperation.idle,
          operationStatus: () => OperationStatus.success,
          availableModulesByYear: modulesByYear));
    });
  }

  void _onModuleToggled(ModuleToggled event, Emitter<ProfileSetupState> emit) {
    final modulesByYear =
        Map<int, List<ModuleModel>>.from(state.selectedModulesByYear);
    final yearModules =
        List<ModuleModel>.from(modulesByYear[event.forYear] ?? []);

    if (yearModules.contains(event.module)) {
      log('ProfileSetupBloc: Removing module ${event.module.name} for year ${event.forYear}');
      yearModules.remove(event.module);
    } else {
      log('ProfileSetupBloc: Adding module ${event.module.name} for year ${event.forYear}');
      yearModules.add(event.module);
    }

    modulesByYear[event.forYear] = yearModules;
    log('ProfileSetupBloc: Updated selected modules count for year ${event.forYear}: ${yearModules.length}');

    emit(state.copyWith(
        selectedModulesByYear: modulesByYear,
        selectedModulesError: () => null));
  }

  void _onSubmitProfileRequested(
      SubmitRegistration event, Emitter<ProfileSetupState> emit) async {
    log('ProfileSetupBloc: Attempting to submit profile');

    if (!state.isProfileValid) {
      logError('ProfileSetupBloc: Profile validation failed');
      emit(state.copyWith(
          operationError: () => "Please complete all required information."));
      return;
    }

    log('ProfileSetupBloc: Profile validation successful, proceeding with submission');
    emit(state.copyWith(
        activeOperation: () => ProfileSetupOperation.submittingProfile,
        operationStatus: () => OperationStatus.inProgress,
        operationError: () => null));

    await Future.delayed(const Duration(milliseconds: 1500)); // Simulate upload
    emit(state.copyWith(
        operationStatus: () => OperationStatus.success,
        operationError: () => null));
    // final userProfileSubmission = UserProfileSubmissionEntity(
    //   firstName: state.firstName,
    //   lastName: state.lastName,
    //   selectedCourseId: state.selectedCourse?.id,
    //   selectedYear: state.selectedYear,
    //   selectedSemester: state.selectedSemester,
    //   selectedModuleIds: state.selectedModulesByYear.values.expand((modules) => modules.map((m) => m.id)).toList(),
    // );

    // final result = await _submitRegistration(userProfileSubmission);

    // result.fold(
    //   (failure) {
    //     logError('ProfileSetupBloc: Profile submission failed: ${failure.message}');
    //     emit(state.copyWith(
    //         operationStatus: () => OperationStatus.failure,
    //       generalError: () => failure.message,
    //     ));
    //   },
    //   (_) {
    //     log('ProfileSetupBloc: Profile submission completed');
    //     emit(state.copyWith(flow: ProfileSetupStep.completed));
    //   },
    // );
  }

  Future<void> _onSelectedYearsChanged(
      // Made async
      SelectedYearsChanged event,
      Emitter<ProfileSetupState> emit) async {
    final Set<int> newSelectedYearsSet = event.years;
    log('ProfileSetupBloc: Selected years changed to ${newSelectedYearsSet.join(', ')}');

    // Determine which years were newly selected and don't have modules loaded yet
    final List<int> newlySelectedYearsNeedingLoad = newSelectedYearsSet
        .where((year) => !state.availableModulesByYear.containsKey(year))
        .toList();

    // Update selectedYears in state immediately for UI responsiveness
    // Also, remove modules for years that are no longer selected.
    final Map<int, List<ModuleModel>> updatedAvailableModulesByYear =
        Map.from(state.availableModulesByYear)
          ..removeWhere((year, _) => !newSelectedYearsSet.contains(year));
    final Map<int, List<ModuleModel>> updatedSelectedModulesByYear =
        Map.from(state.selectedModulesByYear)
          ..removeWhere((year, _) => !newSelectedYearsSet.contains(year));

    emit(state.copyWith(
      selectedYears: newSelectedYearsSet,
      availableModulesByYear: updatedAvailableModulesByYear,
      selectedModulesByYear: updatedSelectedModulesByYear,
      isLoadingAdditionalModules: newlySelectedYearsNeedingLoad.isNotEmpty,
    ));

    if (newlySelectedYearsNeedingLoad.isNotEmpty) {
      log('ProfileSetupBloc: Loading modules for newly selected years: ${newlySelectedYearsNeedingLoad.join(', ')}');

      Map<int, List<ModuleModel>> currentAvailableModules = Map.from(
          updatedAvailableModulesByYear); // Start with already filtered
      String? batchError;

      try {
        final List<Future<void>> moduleLoadFutures = [];

        for (final int year in newlySelectedYearsNeedingLoad) {
          if (state.selectedCourse == null || state.selectedSemester == null) {
            logError(
                'ProfileSetupBloc: Cannot load modules for year $year - missing course or semester info.');
            continue;
          }
          final params = GetModulesParams(
            courseId: state.selectedCourse!.id,
            year: year,
            semester: state.selectedSemester!,
          );
          moduleLoadFutures.add(_getModules(params).then((modulesResult) {
            modulesResult.fold(
              (failure) {
                logError(
                    'ProfileSetupBloc: Failed to load modules for year $year - ${failure.message}');
                batchError = (batchError ?? "") +
                    "Failed to load modules for year $year. ";
              },
              (modules) {
                log('ProfileSetupBloc: Successfully loaded ${modules.length} modules for year $year');
                currentAvailableModules[year] = modules;
              },
            );
          }));
        }
        await Future.wait(moduleLoadFutures);
      } catch (e) {
        logError(
            'ProfileSetupBloc: Exception during batch module loading - $e');
        batchError = (batchError ?? "") + "An unexpected error occurred. ";
      } finally {
        log('ProfileSetupBloc: Finished loading additional modules. Available: ${currentAvailableModules.keys.join(", ")}');
        emit(state.copyWith(
          availableModulesByYear: currentAvailableModules,
          isLoadingAdditionalModules: false,
          operationError: () => batchError?.trim(),
        ));
      }
    }
  }
}
