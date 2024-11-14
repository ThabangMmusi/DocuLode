import 'package:get_it/get_it.dart';
import 'package:its_shared/features/setup/data/repositories/setup_repositories_impl.dart';
import 'package:its_shared/features/setup/data/source/setup_data_source.dart';
import 'package:its_shared/features/setup/domain/repositories/setup_repositories.dart';
import 'package:its_shared/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:its_shared/features/upload_progress/data/sources/upload_file_sources.dart';
import 'package:its_shared/features/upload_progress/domain/domain.dart';
import 'package:its_shared/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';
import 'package:its_shared/features/uploads/domain/repositories/uploads_repositories.dart';
import 'package:its_shared/features/uploads/domain/usecases/get_uploads.dart';

import 'core/bloc/auth/auth_bloc.dart';
import 'core/common/models/models.dart';
import 'features/setup/domain/usecases/setup_usecases.dart';
import 'features/shared/data/repositories/shared_repositories_impl.dart';
import 'features/shared/data/source/shared_source.dart';
import 'features/shared/domain/repositories/shared_repositories.dart';
import 'features/shared/domain/usecases/download_file.dart';
import 'features/shared/domain/usecases/get_shared_file.dart';
import 'features/shared/presentation/bloc/shared_bloc.dart';
import 'features/upload_edit/data/repositories/upload_edit_repositories_impl.dart';
import 'features/upload_edit/data/source/upload_edit_source.dart';
import 'features/upload_edit/domain/repositories/upload_edit_repositories.dart';
import 'features/upload_edit/domain/usecases/get_sorted_modules.dart';
import 'features/upload_edit/domain/usecases/update_file.dart';
import 'features/upload_edit/presentation/bloc/upload_edit_bloc.dart';
import 'features/upload_progress/data/repositories/upload_file_repository_impl.dart';
import 'features/uploads/data/repositories/uploads_repositories_impl.dart';
import 'features/uploads/data/source/uploads_source.dart';
import 'features/uploads/presentation/bloc/uploads_bloc.dart';
import 'services/firebase/firebase_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final FirebaseService firebase = FirebaseFactory.create();

  serviceLocator.registerLazySingleton(() => firebase);
  serviceLocator.registerLazySingleton(() => AppModel());
  _initAuth();
  _initSetup();
  _initFilesUploads();
  _initFilesUploadEdit();
  _initFilesUploadProgress();

  _initSharedFiles();
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

void _initAuth() {
  // Datasource
  // serviceLocator
  //   ..registerFactory<AuthRemoteDataSource>(
  //     () => AuthRemoteDataSourceImpl(
  //       serviceLocator(),
  //     ),
  //   )
  //   // Repository
  //   ..registerFactory<AuthRepository>(
  //     () => AuthRepositoryImpl(
  //       serviceLocator(),
  //       serviceLocator(),
  //     ),
  //   )
  //   // Usecases
  //   ..registerFactory(
  //     () => UserSignUp(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //     () => UserLogin(
  //       serviceLocator(),
  //     ),
  //   )
  //   ..registerFactory(
  //     () => CurrentUser(
  //       serviceLocator(),
  //     ),
  //   )
  // Bloc
  serviceLocator.registerLazySingleton(() => AuthBloc());
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

void _initSetup() {
  // Datasource
  serviceLocator
    ..registerFactory<SetupDataSource>(() => SetupDataSourceImpl())
    // Repository
    ..registerFactory<SetUpRepository>(() => SetupRepositoriesImpl())
    // Usecases
    ..registerFactory(() => GetAllCourses())
    ..registerFactory(() => GetCourseModules())
    ..registerFactory(() => UpdateUser())
    // Bloc
    ..registerLazySingleton(() => SetupBloc());
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
