import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/common/settings/data/repositories/base_settings_repository_impl.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/setting_repositories.dart';
import '../source/settings_data_source.dart';

class SettingsRepositoryImpl extends BaseSettingsRepositoryImpl
    implements SettingsRepository {
  final SettingsDataSource _dataSource;

  SettingsRepositoryImpl({required super.dataSource, required SettingsDataSource settingsDataSource}) : _dataSource = settingsDataSource;

  @override
  Future<Either<Failure, void>> updateUserProfile({
    required String names,
    required String surname,
  }) async {
    try {
      await _dataSource.updateUserProfile(
        names: names,
        surname: surname,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppearance({
    required String theme,
  }) async {
    try {
      await _dataSource.updateAppearance(theme: theme);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await _dataSource.deleteAccount();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
