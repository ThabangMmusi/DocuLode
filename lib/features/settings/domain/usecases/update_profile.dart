import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/core.dart';

import '../repositories/setting_repositories.dart';

class UpdateProfile implements UseCase<void, ProfileParams> {
  final SettingsRepository _settingsRepository;

  UpdateProfile(this._settingsRepository);

  @override
  Future<Either<Failure, void>> call(ProfileParams params) => 
    _settingsRepository.updateUserProfile(
      names: params.names,
      surname: params.surname,
    );
}

class ProfileParams {
  const ProfileParams({
    required this.names,
    required this.surname,
  });

  final String names;
  final String surname;
}