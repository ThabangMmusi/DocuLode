// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ModuleModel _$ModuleModelFromJson(Map<String, dynamic> json) {
  return _ModuleModel.fromJson(json);
}

/// @nodoc
mixin _$ModuleModel {
  String? get id => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get courses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ModuleModelCopyWith<ModuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModuleModelCopyWith<$Res> {
  factory $ModuleModelCopyWith(
          ModuleModel value, $Res Function(ModuleModel) then) =
      _$ModuleModelCopyWithImpl<$Res, ModuleModel>;
  @useResult
  $Res call({String? id, int level, String name, List<String> courses});
}

/// @nodoc
class _$ModuleModelCopyWithImpl<$Res, $Val extends ModuleModel>
    implements $ModuleModelCopyWith<$Res> {
  _$ModuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? level = null,
    Object? name = null,
    Object? courses = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      courses: null == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModuleModelImplCopyWith<$Res>
    implements $ModuleModelCopyWith<$Res> {
  factory _$$ModuleModelImplCopyWith(
          _$ModuleModelImpl value, $Res Function(_$ModuleModelImpl) then) =
      __$$ModuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, int level, String name, List<String> courses});
}

/// @nodoc
class __$$ModuleModelImplCopyWithImpl<$Res>
    extends _$ModuleModelCopyWithImpl<$Res, _$ModuleModelImpl>
    implements _$$ModuleModelImplCopyWith<$Res> {
  __$$ModuleModelImplCopyWithImpl(
      _$ModuleModelImpl _value, $Res Function(_$ModuleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? level = null,
    Object? name = null,
    Object? courses = null,
  }) {
    return _then(_$ModuleModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      courses: null == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ModuleModelImpl with DiagnosticableTreeMixin implements _ModuleModel {
  const _$ModuleModelImpl(
      {this.id,
      required this.level,
      required this.name,
      required final List<String> courses})
      : _courses = courses;

  factory _$ModuleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModuleModelImplFromJson(json);

  @override
  final String? id;
  @override
  final int level;
  @override
  final String name;
  final List<String> _courses;
  @override
  List<String> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ModuleModel(id: $id, level: $level, name: $name, courses: $courses)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ModuleModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('level', level))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('courses', courses));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModuleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._courses, _courses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, level, name,
      const DeepCollectionEquality().hash(_courses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModuleModelImplCopyWith<_$ModuleModelImpl> get copyWith =>
      __$$ModuleModelImplCopyWithImpl<_$ModuleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ModuleModelImplToJson(
      this,
    );
  }
}

abstract class _ModuleModel implements ModuleModel {
  const factory _ModuleModel(
      {final String? id,
      required final int level,
      required final String name,
      required final List<String> courses}) = _$ModuleModelImpl;

  factory _ModuleModel.fromJson(Map<String, dynamic> json) =
      _$ModuleModelImpl.fromJson;

  @override
  String? get id;
  @override
  int get level;
  @override
  String get name;
  @override
  List<String> get courses;
  @override
  @JsonKey(ignore: true)
  _$$ModuleModelImplCopyWith<_$ModuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
