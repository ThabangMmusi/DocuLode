part of 'profile_setup_bloc.dart';

class ProfileSetupState extends Equatable {
  final ProfileSetupStep currentFlow;
  final String firstName;
  final String? firstNameError;
  final String lastName;
  final String? lastNameError;
  final File? profileImageFile;
  final String? profileImageError;
  // Academic details
  final List<CourseModel> availableCourses;
  final CourseModel? selectedCourse;
  final String? selectedCourseError;
  final int? selectedYear;
  final String? selectedYearError;
  final Set<int> selectedYears;

  final List<int> availableSemesters;
  final int? selectedSemester;
  final String? selectedSemesterError;

  // Module selection
  final Map<int, List<ModuleModel>> availableModulesByYear;
  final Map<int, List<ModuleModel>> selectedModulesByYear;
  final String? selectedModulesError;

  final ProfileSetupOperation? activeOperation;
  final OperationStatus? operationStatus;
  final String? generalError;
  final bool isLoadingAdditionalModules;
  const ProfileSetupState({
    this.currentFlow = ProfileSetupStep.academicFoundation,
    this.firstName = '',
    this.firstNameError,
    this.lastName = '',
    this.lastNameError,
    this.profileImageFile,
    this.profileImageError,
    this.availableCourses = const [],
    this.selectedCourse,
    this.selectedCourseError,
    this.selectedYear,
    this.selectedYearError,
    this.selectedYears = const {},
    this.availableSemesters = const [1, 2],
    this.selectedSemester,
    this.selectedSemesterError,
    this.availableModulesByYear = const {},
    this.selectedModulesByYear = const {},
    this.selectedModulesError,
    this.activeOperation,
    this.operationStatus,
    this.generalError,
    this.isLoadingAdditionalModules = false,
  });

  bool get isPersonalDetailsValid =>
      firstName.isNotEmpty &&
      firstNameError == null &&
      lastName.isNotEmpty &&
      lastNameError == null;

  bool get isAcademicFoundationValid =>
      selectedCourse != null &&
      selectedCourseError == null &&
      selectedYear != null &&
      selectedYearError == null &&
      selectedSemester != null &&
      selectedSemesterError == null;
  bool get isModulesValid =>
      selectedModulesByYear.values.any((modules) => modules.isNotEmpty) &&
      selectedModulesError == null;

  bool get isProfileValid =>
      isPersonalDetailsValid && isAcademicFoundationValid && isModulesValid;
  ProfileSetupState copyWith({
    ProfileSetupStep? flow,
    String? firstName,
    String? Function()? firstNameError,
    String? lastName,
    String? Function()? lastNameError,
    File? Function()? profileImageFile,
    String? Function()? profileImageError,
    List<CourseModel>? availableCourses,
    CourseModel? Function()? selectedCourse,
    String? Function()? selectedCourseError,
    int? Function()? selectedYear,
    String? Function()? selectedYearError,
    Set<int>? selectedYears,
    List<int>? availableSemesters,
    int? Function()? selectedSemester,
    String? Function()? selectedSemesterError,
    Map<int, List<ModuleModel>>? availableModulesByYear,
    Map<int, List<ModuleModel>>? selectedModulesByYear,
    String? Function()? selectedModulesError,
    ProfileSetupOperation? Function()? activeOperation,
    OperationStatus? Function()? operationStatus,
    String? Function()? operationError,
    bool? isLoadingAdditionalModules,
  }) {
    return ProfileSetupState(
      currentFlow: flow ?? this.currentFlow,
      firstName: firstName ?? this.firstName,
      firstNameError:
          firstNameError != null ? firstNameError() : this.firstNameError,
      lastName: lastName ?? this.lastName,
      lastNameError:
          lastNameError != null ? lastNameError() : this.lastNameError,
      profileImageFile:
          profileImageFile != null ? profileImageFile() : this.profileImageFile,
      profileImageError: profileImageError != null
          ? profileImageError()
          : this.profileImageError,
      availableCourses: availableCourses ?? this.availableCourses,
      selectedCourse:
          selectedCourse != null ? selectedCourse() : this.selectedCourse,
      selectedCourseError: selectedCourseError != null
          ? selectedCourseError()
          : this.selectedCourseError,
      selectedYear: selectedYear != null ? selectedYear() : this.selectedYear,
      selectedYearError: selectedYearError != null
          ? selectedYearError()
          : this.selectedYearError,
      selectedYears: selectedYears ?? this.selectedYears,
      availableSemesters: availableSemesters ?? this.availableSemesters,
      selectedSemester:
          selectedSemester != null ? selectedSemester() : this.selectedSemester,
      selectedSemesterError: selectedSemesterError != null
          ? selectedSemesterError()
          : this.selectedSemesterError,
      availableModulesByYear:
          availableModulesByYear ?? this.availableModulesByYear,
      selectedModulesByYear:
          selectedModulesByYear ?? this.selectedModulesByYear,
      selectedModulesError: selectedModulesError != null
          ? selectedModulesError()
          : this.selectedModulesError,
      activeOperation:
          activeOperation != null ? activeOperation() : this.activeOperation,
      operationStatus:
          operationStatus != null ? operationStatus() : this.operationStatus,
      generalError: operationError != null ? operationError() : this.generalError,
      isLoadingAdditionalModules:
          isLoadingAdditionalModules ?? this.isLoadingAdditionalModules,
    );
  }

  @override
  List<Object?> get props => [
        currentFlow,
        firstName,
        firstNameError,
        lastName,
        lastNameError,
        profileImageFile,
        profileImageError,
        availableCourses,
        selectedCourse,
        selectedCourseError,
        selectedYear,
        selectedYearError,
        selectedYears,
        availableSemesters,
        selectedSemester,
        selectedSemesterError,
        availableModulesByYear,
        selectedModulesByYear,
        selectedModulesError,
        activeOperation,
        operationStatus,
        generalError,
        isLoadingAdditionalModules,
      ];
}
