// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {
  String? get id;
  String? get names;
  String? get surname;
  String? get email;
  String? get photoUrl;
  int? get year;
  int? get semester;
  @CourseConverter()
  CourseModel? get course;
  @ModuleConverter()
  List<ModuleModel>? get modules;
  String? get type;
  String? get token;
  String? get refreshToken;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<AppUser> get copyWith =>
      _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.names, names) || other.names == names) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            (identical(other.course, course) || other.course == course) &&
            const DeepCollectionEquality().equals(other.modules, modules) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      names,
      surname,
      email,
      photoUrl,
      year,
      semester,
      course,
      const DeepCollectionEquality().hash(modules),
      type,
      token,
      refreshToken);

  @override
  String toString() {
    return 'AppUser(id: $id, names: $names, surname: $surname, email: $email, photoUrl: $photoUrl, year: $year, semester: $semester, course: $course, modules: $modules, type: $type, token: $token, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) =
      _$AppUserCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String? names,
      String? surname,
      String? email,
      String? photoUrl,
      int? year,
      int? semester,
      @CourseConverter() CourseModel? course,
      @ModuleConverter() List<ModuleModel>? modules,
      String? type,
      String? token,
      String? refreshToken});

  $CourseModelCopyWith<$Res>? get course;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? names = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
    Object? year = freezed,
    Object? semester = freezed,
    Object? course = freezed,
    Object? modules = freezed,
    Object? type = freezed,
    Object? token = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      names: freezed == names
          ? _self.names
          : names // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      semester: freezed == semester
          ? _self.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int?,
      course: freezed == course
          ? _self.course
          : course // ignore: cast_nullable_to_non_nullable
              as CourseModel?,
      modules: freezed == modules
          ? _self.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseModelCopyWith<$Res>? get course {
    if (_self.course == null) {
      return null;
    }

    return $CourseModelCopyWith<$Res>(_self.course!, (value) {
      return _then(_self.copyWith(course: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _AppUser extends AppUser {
  const _AppUser(
      {this.id,
      this.names,
      this.surname,
      this.email,
      this.photoUrl,
      this.year,
      this.semester,
      @CourseConverter() this.course,
      @ModuleConverter() final List<ModuleModel>? modules,
      this.type,
      this.token,
      this.refreshToken})
      : _modules = modules,
        super._();
  factory _AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  @override
  final String? id;
  @override
  final String? names;
  @override
  final String? surname;
  @override
  final String? email;
  @override
  final String? photoUrl;
  @override
  final int? year;
  @override
  final int? semester;
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

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppUserCopyWith<_AppUser> get copyWith =>
      __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.names, names) || other.names == names) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.semester, semester) ||
                other.semester == semester) &&
            (identical(other.course, course) || other.course == course) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      names,
      surname,
      email,
      photoUrl,
      year,
      semester,
      course,
      const DeepCollectionEquality().hash(_modules),
      type,
      token,
      refreshToken);

  @override
  String toString() {
    return 'AppUser(id: $id, names: $names, surname: $surname, email: $email, photoUrl: $photoUrl, year: $year, semester: $semester, course: $course, modules: $modules, type: $type, token: $token, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) =
      __$AppUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? names,
      String? surname,
      String? email,
      String? photoUrl,
      int? year,
      int? semester,
      @CourseConverter() CourseModel? course,
      @ModuleConverter() List<ModuleModel>? modules,
      String? type,
      String? token,
      String? refreshToken});

  @override
  $CourseModelCopyWith<$Res>? get course;
}

/// @nodoc
class __$AppUserCopyWithImpl<$Res> implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? names = freezed,
    Object? surname = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
    Object? year = freezed,
    Object? semester = freezed,
    Object? course = freezed,
    Object? modules = freezed,
    Object? type = freezed,
    Object? token = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_AppUser(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      names: freezed == names
          ? _self.names
          : names // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      semester: freezed == semester
          ? _self.semester
          : semester // ignore: cast_nullable_to_non_nullable
              as int?,
      course: freezed == course
          ? _self.course
          : course // ignore: cast_nullable_to_non_nullable
              as CourseModel?,
      modules: freezed == modules
          ? _self._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseModelCopyWith<$Res>? get course {
    if (_self.course == null) {
      return null;
    }

    return $CourseModelCopyWith<$Res>(_self.course!, (value) {
      return _then(_self.copyWith(course: value));
    });
  }
}

// dart format on
