// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String? get id => throw _privateConstructorUsedError;
  String? get names => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  @CourseConverter()
  CourseModel? get course => throw _privateConstructorUsedError;
  @ModuleConverter()
  List<ModuleModel>? get modules => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String? id,
      String? names,
      String? surname,
      int? level,
      @CourseConverter() CourseModel? course,
      @ModuleConverter() List<ModuleModel>? modules,
      String? type,
      String? token,
      String? refreshToken});

  $CourseModelCopyWith<$Res>? get course;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? names = freezed,
    Object? surname = freezed,
    Object? level = freezed,
    Object? course = freezed,
    Object? modules = freezed,
    Object? type = freezed,
    Object? token = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      names: freezed == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      course: freezed == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as CourseModel?,
      modules: freezed == modules
          ? _value.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CourseModelCopyWith<$Res>? get course {
    if (_value.course == null) {
      return null;
    }

    return $CourseModelCopyWith<$Res>(_value.course!, (value) {
      return _then(_value.copyWith(course: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? names,
      String? surname,
      int? level,
      @CourseConverter() CourseModel? course,
      @ModuleConverter() List<ModuleModel>? modules,
      String? type,
      String? token,
      String? refreshToken});

  @override
  $CourseModelCopyWith<$Res>? get course;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? names = freezed,
    Object? surname = freezed,
    Object? level = freezed,
    Object? course = freezed,
    Object? modules = freezed,
    Object? type = freezed,
    Object? token = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$AppUserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      names: freezed == names
          ? _value.names
          : names // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      course: freezed == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as CourseModel?,
      modules: freezed == modules
          ? _value._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl(
      {this.id,
      this.names,
      this.surname,
      this.level,
      @CourseConverter() this.course,
      @ModuleConverter() final List<ModuleModel>? modules,
      this.type,
      this.token,
      this.refreshToken})
      : _modules = modules,
        super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String? id;
  @override
  final String? names;
  @override
  final String? surname;
  @override
  final int? level;
  @override
  @CourseConverter()
  final CourseModel? course;
  final List<ModuleModel>? _modules;
  @override
  @ModuleConverter()
  List<ModuleModel>? get modules {
    final value = _modules;
    if (value == null) return null;
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? type;
  @override
  final String? token;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'AppUser(id: $id, names: $names, surname: $surname, level: $level, course: $course, modules: $modules, type: $type, token: $token, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.names, names) || other.names == names) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.course, course) || other.course == course) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      names,
      surname,
      level,
      course,
      const DeepCollectionEquality().hash(_modules),
      type,
      token,
      refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser(
      {final String? id,
      final String? names,
      final String? surname,
      final int? level,
      @CourseConverter() final CourseModel? course,
      @ModuleConverter() final List<ModuleModel>? modules,
      final String? type,
      final String? token,
      final String? refreshToken}) = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String? get id;
  @override
  String? get names;
  @override
  String? get surname;
  @override
  int? get level;
  @override
  @CourseConverter()
  CourseModel? get course;
  @override
  @ModuleConverter()
  List<ModuleModel>? get modules;
  @override
  String? get type;
  @override
  String? get token;
  @override
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
