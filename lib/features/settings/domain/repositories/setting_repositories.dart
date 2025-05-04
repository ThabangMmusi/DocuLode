import 'package:fpdart/fpdart.dart';
import 'package:its_shared/core/error/failures.dart';

import '../../../../core/common/settings/domain/repositories/base_settings_repository.dart';

abstract interface class SettingsRepository implements BaseSettingsRepository {
 /// Update user profile information
  Future<Either<Failure, void>> updateUserProfile({
    required String names,
    required String surname,
  });
  
  /// Update app appearance settings
  Future<Either<Failure, void>> updateAppearance({
    required String theme,
  });
  
  /// Delete user account
  Future<Either<Failure, void>> deleteAccount();
}
