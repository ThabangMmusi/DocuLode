import 'package:doculode/core/index.dart';

import 'package:fpdart/fpdart.dart';

import 'repositories/base_settings_repository.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final BaseSettingsRepository _settingsRepository;

  UserSignOut(this._settingsRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) =>
      _settingsRepository.signOut();
}
