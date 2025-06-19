// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModuleManager {
  List<ModuleModel>? get modules;
  List<String>? get predecessors;

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModuleManagerCopyWith<ModuleManager> get copyWith =>
      _$ModuleManagerCopyWithImpl<ModuleManager>(
          this as ModuleManager, _$identity);

  /// Serializes this ModuleManager to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModuleManager &&
            const DeepCollectionEquality().equals(other.modules, modules) &&
            const DeepCollectionEquality()
                .equals(other.predecessors, predecessors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(modules),
      const DeepCollectionEquality().hash(predecessors));

  @override
  String toString() {
    return 'ModuleManager(modules: $modules, predecessors: $predecessors)';
  }
}

/// @nodoc
abstract mixin class $ModuleManagerCopyWith<$Res> {
  factory $ModuleManagerCopyWith(
          ModuleManager value, $Res Function(ModuleManager) _then) =
      _$ModuleManagerCopyWithImpl;
  @useResult
  $Res call({List<ModuleModel>? modules, List<String>? predecessors});
}

/// @nodoc
class _$ModuleManagerCopyWithImpl<$Res>
    implements $ModuleManagerCopyWith<$Res> {
  _$ModuleManagerCopyWithImpl(this._self, this._then);

  final ModuleManager _self;
  final $Res Function(ModuleManager) _then;

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modules = freezed,
    Object? predecessors = freezed,
  }) {
    return _then(_self.copyWith(
      modules: freezed == modules
          ? _self.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      predecessors: freezed == predecessors
          ? _self.predecessors
          : predecessors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ModuleManager extends ModuleManager {
  const _ModuleManager(
      {final List<ModuleModel>? modules, final List<String>? predecessors})
      : _modules = modules,
        _predecessors = predecessors,
        super._();
  factory _ModuleManager.fromJson(Map<String, dynamic> json) =>
      _$ModuleManagerFromJson(json);

  final List<ModuleModel>? _modules;
  @override
  List<ModuleModel>? get modules {
    final value = _modules;
    if (value == null) return null;
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _predecessors;
  @override
  List<String>? get predecessors {
    final value = _predecessors;
    if (value == null) return null;
    if (_predecessors is EqualUnmodifiableListView) return _predecessors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModuleManagerCopyWith<_ModuleManager> get copyWith =>
      __$ModuleManagerCopyWithImpl<_ModuleManager>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ModuleManagerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModuleManager &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            const DeepCollectionEquality()
                .equals(other._predecessors, _predecessors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_modules),
      const DeepCollectionEquality().hash(_predecessors));

  @override
  String toString() {
    return 'ModuleManager(modules: $modules, predecessors: $predecessors)';
  }
}

/// @nodoc
abstract mixin class _$ModuleManagerCopyWith<$Res>
    implements $ModuleManagerCopyWith<$Res> {
  factory _$ModuleManagerCopyWith(
          _ModuleManager value, $Res Function(_ModuleManager) _then) =
      __$ModuleManagerCopyWithImpl;
  @override
  @useResult
  $Res call({List<ModuleModel>? modules, List<String>? predecessors});
}

/// @nodoc
class __$ModuleManagerCopyWithImpl<$Res>
    implements _$ModuleManagerCopyWith<$Res> {
  __$ModuleManagerCopyWithImpl(this._self, this._then);

  final _ModuleManager _self;
  final $Res Function(_ModuleManager) _then;

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? modules = freezed,
    Object? predecessors = freezed,
  }) {
    return _then(_ModuleManager(
      modules: freezed == modules
          ? _self._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      predecessors: freezed == predecessors
          ? _self._predecessors
          : predecessors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

// dart format on
