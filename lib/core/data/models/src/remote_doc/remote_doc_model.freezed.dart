// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_doc_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RemoteDocModel _$RemoteDocModelFromJson(Map<String, dynamic> json) {
  return _RemoteDocModel.fromJson(json);
}

/// @nodoc
mixin _$RemoteDocModel {
  String? get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get uploaded => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  @AccessConverter()
  AccessType get access => throw _privateConstructorUsedError;
  @CategoryConverter()
  UploadCategory? get type => throw _privateConstructorUsedError;
  @ModuleConverter()
  List<ModuleModel>? get modules => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get like => throw _privateConstructorUsedError;
  List<String> get dislike => throw _privateConstructorUsedError;
  int get downloads => throw _privateConstructorUsedError;

  /// Serializes this RemoteDocModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemoteDocModelCopyWith<RemoteDocModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteDocModelCopyWith<$Res> {
  factory $RemoteDocModelCopyWith(
          RemoteDocModel value, $Res Function(RemoteDocModel) then) =
      _$RemoteDocModelCopyWithImpl<$Res, RemoteDocModel>;
  @useResult
  $Res call(
      {String? id,
      String url,
      @TimestampConverter() DateTime? uploaded,
      String uid,
      String size,
      @AccessConverter() AccessType access,
      @CategoryConverter() UploadCategory? type,
      @ModuleConverter() List<ModuleModel>? modules,
      String name,
      List<String> like,
      List<String> dislike,
      int downloads});
}

/// @nodoc
class _$RemoteDocModelCopyWithImpl<$Res, $Val extends RemoteDocModel>
    implements $RemoteDocModelCopyWith<$Res> {
  _$RemoteDocModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = null,
    Object? uploaded = freezed,
    Object? uid = null,
    Object? size = null,
    Object? access = freezed,
    Object? type = freezed,
    Object? modules = freezed,
    Object? name = null,
    Object? like = null,
    Object? dislike = null,
    Object? downloads = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploaded: freezed == uploaded
          ? _value.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      access: freezed == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as AccessType,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UploadCategory?,
      modules: freezed == modules
          ? _value.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      like: null == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dislike: null == dislike
          ? _value.dislike
          : dislike // ignore: cast_nullable_to_non_nullable
              as List<String>,
      downloads: null == downloads
          ? _value.downloads
          : downloads // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemoteDocModelImplCopyWith<$Res>
    implements $RemoteDocModelCopyWith<$Res> {
  factory _$$RemoteDocModelImplCopyWith(_$RemoteDocModelImpl value,
          $Res Function(_$RemoteDocModelImpl) then) =
      __$$RemoteDocModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String url,
      @TimestampConverter() DateTime? uploaded,
      String uid,
      String size,
      @AccessConverter() AccessType access,
      @CategoryConverter() UploadCategory? type,
      @ModuleConverter() List<ModuleModel>? modules,
      String name,
      List<String> like,
      List<String> dislike,
      int downloads});
}

/// @nodoc
class __$$RemoteDocModelImplCopyWithImpl<$Res>
    extends _$RemoteDocModelCopyWithImpl<$Res, _$RemoteDocModelImpl>
    implements _$$RemoteDocModelImplCopyWith<$Res> {
  __$$RemoteDocModelImplCopyWithImpl(
      _$RemoteDocModelImpl _value, $Res Function(_$RemoteDocModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = null,
    Object? uploaded = freezed,
    Object? uid = null,
    Object? size = null,
    Object? access = freezed,
    Object? type = freezed,
    Object? modules = freezed,
    Object? name = null,
    Object? like = null,
    Object? dislike = null,
    Object? downloads = null,
  }) {
    return _then(_$RemoteDocModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploaded: freezed == uploaded
          ? _value.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      access: freezed == access
          ? _value.access
          : access // ignore: cast_nullable_to_non_nullable
              as AccessType,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as UploadCategory?,
      modules: freezed == modules
          ? _value._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      like: null == like
          ? _value._like
          : like // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dislike: null == dislike
          ? _value._dislike
          : dislike // ignore: cast_nullable_to_non_nullable
              as List<String>,
      downloads: null == downloads
          ? _value.downloads
          : downloads // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoteDocModelImpl extends _RemoteDocModel {
  const _$RemoteDocModelImpl(
      {this.id,
      this.url = "",
      @TimestampConverter() this.uploaded,
      this.uid = "",
      this.size = "",
      @AccessConverter() this.access = AccessType.unpublished,
      @CategoryConverter() this.type,
      @ModuleConverter() final List<ModuleModel>? modules,
      this.name = "",
      final List<String> like = const [],
      final List<String> dislike = const [],
      this.downloads = 0})
      : _modules = modules,
        _like = like,
        _dislike = dislike,
        super._();

  factory _$RemoteDocModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoteDocModelImplFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final String url;
  @override
  @TimestampConverter()
  final DateTime? uploaded;
  @override
  @JsonKey()
  final String uid;
  @override
  @JsonKey()
  final String size;
  @override
  @JsonKey()
  @AccessConverter()
  final AccessType access;
  @override
  @CategoryConverter()
  final UploadCategory? type;
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
  @JsonKey()
  final String name;
  final List<String> _like;
  @override
  @JsonKey()
  List<String> get like {
    if (_like is EqualUnmodifiableListView) return _like;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_like);
  }

  final List<String> _dislike;
  @override
  @JsonKey()
  List<String> get dislike {
    if (_dislike is EqualUnmodifiableListView) return _dislike;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dislike);
  }

  @override
  @JsonKey()
  final int downloads;

  @override
  String toString() {
    return 'RemoteDocModel(id: $id, url: $url, uploaded: $uploaded, uid: $uid, size: $size, access: $access, type: $type, modules: $modules, name: $name, like: $like, dislike: $dislike, downloads: $downloads)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoteDocModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploaded, uploaded) ||
                other.uploaded == uploaded) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.size, size) || other.size == size) &&
            const DeepCollectionEquality().equals(other.access, access) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._like, _like) &&
            const DeepCollectionEquality().equals(other._dislike, _dislike) &&
            (identical(other.downloads, downloads) ||
                other.downloads == downloads));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      uploaded,
      uid,
      size,
      const DeepCollectionEquality().hash(access),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_modules),
      name,
      const DeepCollectionEquality().hash(_like),
      const DeepCollectionEquality().hash(_dislike),
      downloads);

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoteDocModelImplCopyWith<_$RemoteDocModelImpl> get copyWith =>
      __$$RemoteDocModelImplCopyWithImpl<_$RemoteDocModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoteDocModelImplToJson(
      this,
    );
  }
}

abstract class _RemoteDocModel extends RemoteDocModel {
  const factory _RemoteDocModel(
      {final String? id,
      final String url,
      @TimestampConverter() final DateTime? uploaded,
      final String uid,
      final String size,
      @AccessConverter() final AccessType access,
      @CategoryConverter() final UploadCategory? type,
      @ModuleConverter() final List<ModuleModel>? modules,
      final String name,
      final List<String> like,
      final List<String> dislike,
      final int downloads}) = _$RemoteDocModelImpl;
  const _RemoteDocModel._() : super._();

  factory _RemoteDocModel.fromJson(Map<String, dynamic> json) =
      _$RemoteDocModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get url;
  @override
  @TimestampConverter()
  DateTime? get uploaded;
  @override
  String get uid;
  @override
  String get size;
  @override
  @AccessConverter()
  AccessType get access;
  @override
  @CategoryConverter()
  UploadCategory? get type;
  @override
  @ModuleConverter()
  List<ModuleModel>? get modules;
  @override
  String get name;
  @override
  List<String> get like;
  @override
  List<String> get dislike;
  @override
  int get downloads;

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoteDocModelImplCopyWith<_$RemoteDocModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
