import 'package:get_it/get_it.dart';
import 'package:its_shared/core/data/repositories/user_repository_impl.dart';
import 'package:its_shared/core/data/source/user_data_source.dart';
import 'package:its_shared/core/domain/repositories/user_repository.dart';

import 'core/common/auth/auth.dart';
import 'core/common/auth/presentation/bloc/auth_bloc.dart';
import 'core/common/settings/settings.dart';
import 'core/data/models/models.dart';
import 'core/domain/usecases/get_current_user.dart';
import 'features/settings/settings.dart';
import 'features/setup/setup.dart';
import 'features/shared/shared.dart';
import 'features/upload_edit/upload_edit.dart';
import 'features/uploads/uploads.dart';
import 'features/upload_progress/upload_progress.dart';
import 'services/firebase/firebase_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final FirebaseService firebase = FirebaseFactory.create();

  serviceLocator.registerLazySingleton(() => firebase);
  serviceLocator.registerLazySingleton(() => AppModel());
  
  _initCore();
  _initAuth();
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
void _initCore(){
  serviceLocator
    // DataSource
    ..registerFactory<UserDataSource>(
      () => UserDataSourceImpl(
        firebaseService: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        dataSource: serviceLocator(),
      ),
    )
    // UseCases
    ..registerFactory(
      () => GetCurrentUser(
        serviceLocator()
      ),
    );
}
void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthDataSource>(
      () => AuthDataSourceImpl(firebaseService: 
        serviceLocator()
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: 
        serviceLocator(), userRepository: serviceLocator(), 
      ),
    )
    // Usecases
    ..registerFactory(
      () => GetAuthUserStream(repository: 
        serviceLocator()
      ),
    ) 
    ..registerFactory(
      () => SignOut(repository: 
        serviceLocator()
      ),
    )
  // Bloc
 ..registerLazySingleton(() => AuthBloc(
    getCurrentUser: serviceLocator(),
    signOut: serviceLocator(),
    authUserStream: serviceLocator(),
  ));
}

void _initFilesUploadEdit() {
  // Datasource
  serviceLocator
    ..registerFactory<UploadEditSource>(
      () => UploadEditSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<UploadEditRepository>(
      () => UploadEditRepositoryImpl(serviceLocator()),
    )
    // Usecases
    ..registerFactory(() => UploadUpdate())
    ..registerFactory(() => GetSortedModules())
    // Bloc
    ..registerLazySingleton(() => UploadEditBloc());
}

void _initFilesUploads() {
  // Datasource
  serviceLocator
    ..registerFactory<UploadsSource>(
      () => UploadsSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<UploadsRepository>(
      () => UploadsRepositoryImpl(serviceLocator()),
    )
    // Usecases
    ..registerFactory(
      () => GetUploads(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => UploadsBloc(
        getUploads: serviceLocator(),
      ),
    );
}

void _initFilesUploadProgress() {
  // Datasource
  serviceLocator
    ..registerFactory<UploadFileSource>(
      () => UploadFileSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<UploadFileRepository>(
      () => UploadFileRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadFile(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => UploadProgressBloc(
        serviceLocator(),
        serviceLocator(),
      ),
    );
}

void _initSharedSettings() {
  // Register shared use cases
  serviceLocator
    ..registerFactory(() => GetAllCourses(serviceLocator()))
    ..registerFactory(() => GetCourseModules(serviceLocator()))
    ..registerFactory(() => UpdateUserEdu(serviceLocator()))
    // Register BaseSettingsRepositoryImpl
    ..registerFactory<BaseSettingsRepository>(() => BaseSettingsRepositoryImpl(dataSource: serviceLocator()))
    ..registerFactory<BaseSettingsDataSource>(() => BaseSettingsDataSourceImpl(firebaseService:  serviceLocator()));
}

void _initSetup() {
  serviceLocator
      // ..registerFactory<SetupDataSource>(() => SetupDataSourceImpl())
      // ..registerFactory<SetUpRepository>(() => SetupRepositoriesImpl())
      .registerLazySingleton(() => SetupBloc(
            getAllCourses: serviceLocator(),
            getSortedModules: serviceLocator(),
            updateUserEdu: serviceLocator(),
          ));
}

void _initSettings() {
  serviceLocator
    ..registerFactory<SettingsDataSource>(() => SettingsDataSourceImpl(firebaseService: serviceLocator()))
    ..registerFactory<SettingsRepository>(() => SettingsRepositoryImpl(dataSource: serviceLocator(), settingsDataSource: serviceLocator (),), )
    ..registerFactory(() => UpdateProfile(serviceLocator()))
    ..registerLazySingleton(() => SettingsBloc(
      getCurrentUser: serviceLocator(),
          getAllCourses: serviceLocator(),
          getSortedModules: serviceLocator(),
          updateProfile: serviceLocator(),
          updateUserEdu: serviceLocator(),

        ));
}

void _initSharedFiles() {
  // Datasource
  serviceLocator
    ..registerFactory<SharedSource>(
      () => SharedSourceImpl(serviceLocator()),
    )
    // Repository
    ..registerFactory<SharedRepository>(
      () => SharedRepositoryImpl(serviceLocator()),
    )
    // Usecases
    ..registerFactory(() => GetSharedFile())
    ..registerFactory(() => DownloadFile())
    // ..registerFactory(() => UploadUpdate())
    // Bloc
    ..registerLazySingleton(() => SharedBloc());
}
