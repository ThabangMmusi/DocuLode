import 'package:doculode/core/index.dart';













import 'package:fpdart/fpdart.dart';


import '../repositories/base_settings_repository.dart';

class UpdateProfile implements UseCase<void, ProfileParams> {
  final BaseSettingsRepository _settingsRepository;

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
