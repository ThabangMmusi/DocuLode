part of 'settings_bloc.dart';

final class SettingsInitialize extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}

final class SettingsProfileUpdate extends BaseSettingsEvent {
  final String names;
  final String surname;
  final String email;

  const SettingsProfileUpdate({
    required this.names,
    required this.surname,
    required this.email,
  });

  @override
  List<Object?> get props => [names, surname, email];
}

final class SettingsAppearanceUpdate extends BaseSettingsEvent {
  final String theme;

  const SettingsAppearanceUpdate({required this.theme});

  @override
  List<Object?> get props => [theme];
}

final class SettingsPreferencesUpdate extends BaseSettingsEvent {
  final bool showRecentLists;
  final bool enableSounds;

  const SettingsPreferencesUpdate({
    required this.showRecentLists,
    required this.enableSounds,
  });

  @override
  List<Object?> get props => [showRecentLists, enableSounds];
}

final class SettingsAccountDelete extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
}
