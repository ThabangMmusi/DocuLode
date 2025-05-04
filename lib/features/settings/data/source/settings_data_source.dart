import 'package:its_shared/_utils/logger.dart';
import 'package:its_shared/core/core.dart';
import 'package:its_shared/injection_container.dart';
import 'package:its_shared/services/firebase/firebase_service.dart';

import '../../../../core/common/settings/data/source/base_settings_data_source.dart';


abstract interface class SettingsDataSource implements BaseSettingsDataSource {
/// Update user profile information
  Future<void> updateUserProfile({
    required String names,
    required String surname,
  });
  
  /// Update app appearance settings
  Future<void> updateAppearance({
    required String theme,
  });

  /// Delete user account
  Future<void> deleteAccount();
}

class SettingsDataSourceImpl extends BaseSettingsDataSourceImpl implements SettingsDataSource  {
  SettingsDataSourceImpl({required super.firebaseService});

 
  @override
  Future<void> updateUserProfile({
    required String names,
    required String surname,
  }) {
    try {
      return firebaseService.updateUser({
        'names': names,
        'surname': surname,
      });
    } catch (e) {
      log("Update profile error: $e");
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> updateAppearance({
    required String theme,
  }) {
    try {
      // return firebaseService.updateUserSettings({
      //   'theme': theme,
      // });
      log("Update appearance error: Not Implemented");
      throw const ServerException("Update appearance error: Not Implemented");
    } catch (e) {
      log("Update appearance error: $e");
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> deleteAccount() {
    try {
      // return firebaseService.deleteUserAccount();
      log("deleteUserAccount error: Not Implemented");
      throw const ServerException("deleteUserAccount error: Not Implemented");

    } catch (e) {
      log("Delete account error: $e");
      throw ServerException(e.toString());
    }
  }}
