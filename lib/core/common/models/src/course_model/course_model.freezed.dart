// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return _CourseModel.fromJson(json);
}

/// @nodoc
mixin _$CourseModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'du')
  int? get duration => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<ModuleModel>? get modules => throw _privateConstructorUsedError;
  List<String>? get predecessors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseModelCopyWith<CourseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseModelCopyWith<$Res> {
  factory $CourseModelCopyWith(
          CourseModel value, $Res Function(CourseModel) then) =
      _$CourseModelCopyWithImpl<$Res, CourseModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'du') int? duration,
      String? name,
      List<ModuleModel>? modules,
      List<String>? predecessors});
}

/// @nodoc
class _$CourseModelCopyWithImpl<$Res, $Val extends CourseModel>
    implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? duration = freezed,
    Object? name = freezed,
    Object? modules = freezed,
    Object? predecessors = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$CourseModelImplCopyWith<$Res>
    implements $CourseModelCopyWith<$Res> {
  factory _$$CourseModelImplCopyWith(
          _$CourseModelImpl value, $Res Function(_$CourseModelImpl) then) =
      __$$CourseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'du') int? duration,
      String? name,
      List<ModuleModel>? modules,
      List<String>? predecessors});
}

/// @nodoc
class __$$CourseModelImplCopyWithImpl<$Res>
    extends _$CourseModelCopyWithImpl<$Res, _$CourseModelImpl>
    implements _$$CourseModelImplCopyWith<$Res> {
  __$$CourseModelImplCopyWithImpl(
      _$CourseModelImpl _value, $Res Function(_$CourseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? duration = freezed,
    Object? name = freezed,
    Object? modules = freezed,
    Object? predecessors = freezed,
  }) {
    return _then(_$CourseModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$CourseModelImpl implements _CourseModel {
  const _$CourseModelImpl(
      {required this.id,
      @JsonKey(name: 'du') this.duration,
      this.name,
      final List<ModuleModel>? modules,
      final List<String>? predecessors})
      : _modules = modules,
        _predecessors = predecessors;

  factory _$CourseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'du')
  final int? duration;
  @override
  final String? name;
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
    return 'CourseModel(id: $id, duration: $duration, name: $name, modules: $modules, predecessors: $predecessors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            const DeepCollectionEquality()
                .equals(other._predecessors, _predecessors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      duration,
      name,
      const DeepCollectionEquality().hash(_modules),
      const DeepCollectionEquality().hash(_predecessors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      __$$CourseModelImplCopyWithImpl<_$CourseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseModelImplToJson(
      this,
    );
  }
}

abstract class _CourseModel implements CourseModel {
  const factory _CourseModel(
      {required final String id,
      @JsonKey(name: 'du') final int? duration,
      final String? name,
      final List<ModuleModel>? modules,
      final List<String>? predecessors}) = _$CourseModelImpl;

  factory _CourseModel.fromJson(Map<String, dynamic> json) =
      _$CourseModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'du')
  int? get duration;
  @override
  String? get name;
  @override
  List<ModuleModel>? get modules;
  @override
  List<String>? get predecessors;
  @override
  @JsonKey(ignore: true)
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
