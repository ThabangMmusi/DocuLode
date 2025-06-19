// This file is now obsolete. All sign-out logic is handled in core/common/settings/.
// You can safely delete this file.

part of 'settings_bloc.dart';

final class SettingsInitialize extends BaseSettingsEvent {
  @override
  List<Object?> get props => [];
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
