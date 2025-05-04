// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ModuleManager _$ModuleManagerFromJson(Map<String, dynamic> json) {
  return _ModuleManager.fromJson(json);
}

/// @nodoc
mixin _$ModuleManager {
  List<ModuleModel>? get modules => throw _privateConstructorUsedError;
  List<String>? get predecessors => throw _privateConstructorUsedError;

  /// Serializes this ModuleManager to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModuleManagerCopyWith<ModuleManager> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModuleManagerCopyWith<$Res> {
  factory $ModuleManagerCopyWith(
          ModuleManager value, $Res Function(ModuleManager) then) =
      _$ModuleManagerCopyWithImpl<$Res, ModuleManager>;
  @useResult
  $Res call({List<ModuleModel>? modules, List<String>? predecessors});
}

/// @nodoc
class _$ModuleManagerCopyWithImpl<$Res, $Val extends ModuleManager>
    implements $ModuleManagerCopyWith<$Res> {
  _$ModuleManagerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modules = freezed,
    Object? predecessors = freezed,
  }) {
    return _then(_value.copyWith(
      modules: freezed == modules
          ? _value.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      predecessors: freezed == predecessors
          ? _value.predecessors
          : predecessors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModuleManagerImplCopyWith<$Res>
    implements $ModuleManagerCopyWith<$Res> {
  factory _$$ModuleManagerImplCopyWith(
          _$ModuleManagerImpl value, $Res Function(_$ModuleManagerImpl) then) =
      __$$ModuleManagerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ModuleModel>? modules, List<String>? predecessors});
}

/// @nodoc
class __$$ModuleManagerImplCopyWithImpl<$Res>
    extends _$ModuleManagerCopyWithImpl<$Res, _$ModuleManagerImpl>
    implements _$$ModuleManagerImplCopyWith<$Res> {
  __$$ModuleManagerImplCopyWithImpl(
      _$ModuleManagerImpl _value, $Res Function(_$ModuleManagerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modules = freezed,
    Object? predecessors = freezed,
  }) {
    return _then(_$ModuleManagerImpl(
      modules: freezed == modules
          ? _value._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      predecessors: freezed == predecessors
          ? _value._predecessors
          : predecessors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModuleManagerImpl implements _ModuleManager {
  const _$ModuleManagerImpl(
      {final List<ModuleModel>? modules, final List<String>? predecessors})
      : _modules = modules,
        _predecessors = predecessors;

  factory _$ModuleManagerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModuleManagerImplFromJson(json);

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

  @override
  String toString() {
    return 'ModuleManager(modules: $modules, predecessors: $predecessors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModuleManagerImpl &&
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

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModuleManagerImplCopyWith<_$ModuleManagerImpl> get copyWith =>
      __$$ModuleManagerImplCopyWithImpl<_$ModuleManagerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModuleManagerImplToJson(
      this,
    );
  }
}

abstract class _ModuleManager implements ModuleManager {
  const factory _ModuleManager(
      {final List<ModuleModel>? modules,
      final List<String>? predecessors}) = _$ModuleManagerImpl;

  factory _ModuleManager.fromJson(Map<String, dynamic> json) =
      _$ModuleManagerImpl.fromJson;

  @override
  List<ModuleModel>? get modules;
  @override
  List<String>? get predecessors;

  /// Create a copy of ModuleManager
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModuleManagerImplCopyWith<_$ModuleManagerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
