import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:its_shared/features/upload_progress/data/sources/upload_file_sources.dart';
import 'package:its_shared/features/upload_progress/domain/domain.dart';
import 'package:its_shared/features/upload_progress/presentation/bloc/upload_progress_bloc.dart';

import 'features/upload_progress/data/repositories/upload_file_repository_impl.dart';
import 'services/firebase/firebase_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final FirebaseService firebase = FirebaseFactory.create();

  final storage = FirebaseStorage.instance;

  serviceLocator.registerLazySingleton(() => firebase);

  serviceLocator.registerLazySingleton(() => storage);
  // _initAuth();
  _initFilesUpload();

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

// void _initAuth() {
//   // Datasource
//   serviceLocator
//     ..registerFactory<AuthRemoteDataSource>(
//       () => AuthRemoteDataSourceImpl(
//         serviceLocator(),
//       ),
//     )
//     // Repository
//     ..registerFactory<AuthRepository>(
//       () => AuthRepositoryImpl(
//         serviceLocator(),
//         serviceLocator(),
//       ),
//     )
//     // Usecases
//     ..registerFactory(
//       () => UserSignUp(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory(
//       () => UserLogin(
//         serviceLocator(),
//       ),
//     )
//     ..registerFactory(
//       () => CurrentUser(
//         serviceLocator(),
//       ),
//     )
//     // Bloc
//     ..registerLazySingleton(
//       () => AuthBloc(
//         userSignUp: serviceLocator(),
//         userLogin: serviceLocator(),
//         currentUser: serviceLocator(),
//         appUserCubit: serviceLocator(),
//       ),
//     );
// }

void _initFilesUpload() {
  // Datasource
  serviceLocator
    ..registerFactory<UploadFileSource>(
      () => UploadFileSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
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
      ),
    );
}
