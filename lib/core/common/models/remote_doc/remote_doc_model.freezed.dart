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
  DateTime get uploaded => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<int> get type => throw _privateConstructorUsedError;
  List<String> get modules => throw _privateConstructorUsedError;
  List<String> get like => throw _privateConstructorUsedError;
  List<String> get dislike => throw _privateConstructorUsedError;
  int get downloads => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      @TimestampConverter() DateTime uploaded,
      String uid,
      String size,
      String name,
      List<int> type,
      List<String> modules,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = null,
    Object? uploaded = null,
    Object? uid = null,
    Object? size = null,
    Object? name = null,
    Object? type = null,
    Object? modules = null,
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
      uploaded: null == uploaded
          ? _value.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as DateTime,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<int>,
      modules: null == modules
          ? _value.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      @TimestampConverter() DateTime uploaded,
      String uid,
      String size,
      String name,
      List<int> type,
      List<String> modules,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? url = null,
    Object? uploaded = null,
    Object? uid = null,
    Object? size = null,
    Object? name = null,
    Object? type = null,
    Object? modules = null,
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
      uploaded: null == uploaded
          ? _value.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as DateTime,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<int>,
      modules: null == modules
          ? _value._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      required this.url,
      @TimestampConverter() required this.uploaded,
      required this.uid,
      required this.size,
      this.name = "",
      final List<int> type = const [],
      final List<String> modules = const [],
      final List<String> like = const [],
      final List<String> dislike = const [],
      this.downloads = 0})
      : _type = type,
        _modules = modules,
        _like = like,
        _dislike = dislike,
        super._();

  factory _$RemoteDocModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoteDocModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String url;
  @override
  @TimestampConverter()
  final DateTime uploaded;
  @override
  final String uid;
  @override
  final String size;
  @override
  @JsonKey()
  final String name;
  final List<int> _type;
  @override
  @JsonKey()
  List<int> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  final List<String> _modules;
  @override
  @JsonKey()
  List<String> get modules {
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modules);
  }

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
    return 'RemoteDocModel(id: $id, url: $url, uploaded: $uploaded, uid: $uid, size: $size, name: $name, type: $type, modules: $modules, like: $like, dislike: $dislike, downloads: $downloads)';
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
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            const DeepCollectionEquality().equals(other._like, _like) &&
            const DeepCollectionEquality().equals(other._dislike, _dislike) &&
            (identical(other.downloads, downloads) ||
                other.downloads == downloads));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      uploaded,
      uid,
      size,
      name,
      const DeepCollectionEquality().hash(_type),
      const DeepCollectionEquality().hash(_modules),
      const DeepCollectionEquality().hash(_like),
      const DeepCollectionEquality().hash(_dislike),
      downloads);

  @JsonKey(ignore: true)
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
      required final String url,
      @TimestampConverter() required final DateTime uploaded,
      required final String uid,
      required final String size,
      final String name,
      final List<int> type,
      final List<String> modules,
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
  DateTime get uploaded;
  @override
  String get uid;
  @override
  String get size;
  @override
  String get name;
  @override
  List<int> get type;
  @override
  List<String> get modules;
  @override
  List<String> get like;
  @override
  List<String> get dislike;
  @override
  int get downloads;
  @override
  @JsonKey(ignore: true)
  _$$RemoteDocModelImplCopyWith<_$RemoteDocModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
