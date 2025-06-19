import 'package:doculode/core/domain/repositories/database_service.dart';
import 'package:doculode/features/azure_sign_in/data/datasources/sign_in_data_source.dart';
import 'package:doculode/features/azure_sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:doculode/features/azure_sign_in/domain/repositories/sign_in_repository.dart';
// import 'package:doculode/features/sign_in/domain/usecases/usecases.dart';
import 'package:get_it/get_it.dart';
import 'package:doculode/core/data/repositories/user_repository_impl.dart';
import 'package:doculode/core/data/source/user_data_source.dart';
import 'package:doculode/core/domain/repositories/user_repository.dart';

import 'package:doculode/core/common/auth/auth.dart';
import 'package:doculode/core/common/settings/settings.dart';
import 'package:doculode/core/domain/usecases/get_current_user.dart';
import 'package:doculode/features/azure_sign_in/domain/usecases/usecases.dart';
import 'package:doculode/features/azure_sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:doculode/features/profile_setup/data/data.dart';
import 'package:doculode/features/profile_setup/domain/usecases/usecases.dart';
import 'package:doculode/features/profile_setup/presentation/bloc/bloc.dart';
import 'package:doculode/features/settings/settings.dart';
import 'package:doculode/features/setup/setup.dart';
import 'package:doculode/features/shared/shared.dart';
import 'package:doculode/features/upload_edit/upload_edit.dart';
import 'package:doculode/features/uploads/uploads.dart';
import 'package:doculode/features/upload_progress/upload_progress.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // sl.registerLazySingleton(() => AppModel());
  _initSupabase();

  // final DatabaseService firebase = FirebaseFactory.create();

  // serviceLocator.registerLazySingleton(() => firebase);

  _initCore();
  _initAuth();
  _initProfileSetup();
  _initSignin();
  _initFilesUploads();
  _initFilesUploadEdit();
  _initFilesUploadProgress();
  _initSharedSettings();
  _initSharedFiles();
  _initSettings();
  _initSetup();
  // serviceLocator.registerFactory(() => InternetConnection());

  // core
  // serviceLocator.registerLazySingleton(
  //   () => AppUserCubit(),
  // );
  // serviceLocator.registerFactory<ConnectionChecker>(
  //   () => ConnectionCheckerImpl(
  //     serviceLocator(),
  //   ),
  // );
}

void _initSupabase() async {
  // Register SupabaseService as a singleton, providing the DatabaseService interface.
  // This means when you request DatabaseService, GetIt will give you the SupabaseServiceImpl instance.
  final DatabaseService supabaseService = DatabaseFactory.create();
  sl.registerLazySingleton<DatabaseService>(() => supabaseService);
  // sl.registerLazySingleton(() => supabaseService);
}

void _initCore() {
  sl
    // DataSource
    ..registerFactory<UserDataSource>(
      () => UserDataSourceImpl(
        databaseService: sl(),
      ),
    )
    // Repository
    ..registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        dataSource: sl(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => GetCurrentUser(sl()),
    );
}

void _initAuth() {
  // Datasource
  sl
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(firebaseService: sl()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authDataSource: sl(),
        userRepository: sl(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => GetAuthUserStream(repository: sl()),
    )
    ..registerFactory(
      () => SignOut(repository: sl()),
    )
    // AuthFormBloc dependencies
    // ..registerFactory(() => ValidateEmailUseCase())
    // ..registerFactory(() => ValidatePasswordUseCase())
    ..registerFactory(() => ValidateNameUseCase())
    // Bloc
    ..registerLazySingleton(() => AuthBloc(
          getCurrentUser: sl(),
          signOut: sl(),
          authUserStream: sl(),
        ));
}

void _initProfileSetup() {
  // Datasource
  sl
    ..registerFactory<ProfileSetupDataSource>(
      () => ProfileSetupRemoteDataSourceImpl(databaseService: sl()),
    )
    ..registerFactory<ProfileSetupRepository>(
      () => ProfileSetupRepositoryImpl(dataSource: sl()),
    )
    ..registerFactory(
      () => GetAvailableCoursesUseCase(repository: sl()),
    )
    ..registerFactory(
      () => GetModulesUseCase(repository: sl()),
    )
    ..registerFactory(
      () => SubmitRegistrationUseCase(repository: sl()),
    )
    ..registerFactory(
      () => UploadProfileImageUseCase(repository: sl()),
    )
    ..registerFactory(() => GetUserNameUseCase(sl()))
    ..registerFactory(
      () => ProfileSetupBloc(
        signOut: sl(),
        getAvailableCourses: sl(),
        getModules: sl(),
        submitRegistration: sl(),
        uploadProfileImage: sl(),
        validateName: sl(),
        getUserName: sl(),
      ),
    );
}

void _initSignin() {
  // Datasource
  sl
    ..registerFactory<SignInDataSource>(
      () => SignInDataSourceImpl(databaseService: sl()),
    )
    // Repository
    ..registerFactory<SignInRepository>(
      () => SignInRepositoryImpl(
        dataSource: sl(),
      ),
    )
    // Usecases
    // ..registerFactory(() => UserLoggedInUseCase(sl()))
    ..registerFactory(() => SignInWithMicrosoftUseCase(sl()))
    // Bloc
    ..registerLazySingleton(() => SignInBloc(
          signInWithMicrosoftUseCase: sl(),
          getAuthUserStream: sl(),
        ));
}

void _initFilesUploadEdit() {
  // Datasource
  sl
    ..registerFactory<UploadEditSource>(
      () => UploadEditSourceImpl(databaseService: sl()),
    )
    // Repository
    ..registerFactory<UploadEditRepository>(
      () => UploadEditRepositoryImpl(sl()),
    )
    // Usecases
    ..registerFactory(() => UploadUpdate())
    ..registerFactory(() => GetSortedModules())
    // Bloc
    ..registerLazySingleton(() => UploadEditBloc());
}

void _initFilesUploads() {
  // Datasource
  sl
    ..registerFactory<UploadsSource>(
      () => UploadsSourceImpl(databaseService: sl()),
    )
    // Repository
    ..registerFactory<UploadsRepository>(
      () => UploadsRepositoryImpl(sl()),
    )
    // Usecases
    ..registerFactory(
      () => GetUploads(
        sl(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => UploadsBloc(
        getUploads: sl(),
        databaseService: sl(),
      ),
    );
}

void _initFilesUploadProgress() {
  // Datasource
  sl
    ..registerFactory<UploadFileSource>(
      () => UploadFileSourceImpl(databaseService: sl()),
    )
    // Repository
    ..registerFactory<UploadFileRepository>(
      () => UploadFileRepositoryImpl(
        sl(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadFile(
        sl(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => UploadProgressBloc(
        sl(),
        sl(),
      ),
    );
}

void _initSharedSettings() {
  // Register shared use cases
  sl
    ..registerFactory(() => GetAllCoursesUsecase(sl()))
    ..registerFactory(() => GetCourseModulesUsecase(sl()))
    ..registerFactory(() => UpdateUserEdu(sl()))
    ..registerFactory(() => UserSignOut(sl()))
    ..registerFactory(() => UpdateProfile(sl()))
    // Register BaseSettingsRepositoryImpl
    ..registerFactory<BaseSettingsRepository>(
        () => BaseSettingsRepositoryImpl(dataSource: sl()))
    ..registerFactory<BaseSettingsDataSource>(
        () => BaseSettingsDataSourceImpl(firebaseService: sl()));
}

void _initSetup() {
  sl
      // ..registerFactory<SetupDataSource>(() => SetupDataSourceImpl())
      // ..registerFactory<SetUpRepository>(() => SetupRepositoriesImpl())
      .registerLazySingleton(() => SetupBloc(
            getAllCourses: sl(),
            getSortedModules: sl(),
            updateUserEdu: sl(),
            validateEmail: sl(),
            validateName: sl(),
            updateProfile: sl(),
            signOut: sl(),
          ));
}

void _initSettings() {
  sl.registerLazySingleton(() => SettingsBloc(
        getCurrentUser: sl(),
        getAllCourses: sl(),
        getSortedModules: sl(),
        updateProfile: sl(),
        updateUserEdu: sl(),
        validateEmail: sl(),
        validateName: sl(),
        signOut: sl(),
      ));
}

void _initSharedFiles() {
  // Datasource
  sl
    ..registerFactory<SharedSource>(
      () => SharedSourceImpl(databaseService: sl()),
    )
    // Repository
    ..registerFactory<SharedRepository>(
      () => SharedRepositoryImpl(sl()),
    )
    // Usecases
    ..registerFactory(() => GetSharedFile())
    ..registerFactory(() => DownloadFile())
    // ..registerFactory(() => UploadUpdate())
    // Bloc
    ..registerLazySingleton(() => SharedBloc());
}
