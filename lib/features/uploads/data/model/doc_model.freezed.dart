// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doc_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DocModel _$DocModelFromJson(Map<String, dynamic> json) {
  return _DocModel.fromJson(json);
}

/// @nodoc
mixin _$DocModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get ext => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get module => throw _privateConstructorUsedError;
  String get uploadDate => throw _privateConstructorUsedError;
  String get uploadedBy => throw _privateConstructorUsedError;
  List<String> get like => throw _privateConstructorUsedError;
  List<String> get dislike => throw _privateConstructorUsedError;
  int get downloads => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocModelCopyWith<DocModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocModelCopyWith<$Res> {
  factory $DocModelCopyWith(DocModel value, $Res Function(DocModel) then) =
      _$DocModelCopyWithImpl<$Res, DocModel>;
  @useResult
  $Res call(
      {String id,
      String type,
      String ext,
      String name,
      String module,
      String uploadDate,
      String uploadedBy,
      List<String> like,
      List<String> dislike,
      int downloads});
}

/// @nodoc
class _$DocModelCopyWithImpl<$Res, $Val extends DocModel>
    implements $DocModelCopyWith<$Res> {
  _$DocModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? ext = null,
    Object? name = null,
    Object? module = null,
    Object? uploadDate = null,
    Object? uploadedBy = null,
    Object? like = null,
    Object? dislike = null,
    Object? downloads = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      ext: null == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      module: null == module
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String,
      uploadDate: null == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DocModelImplCopyWith<$Res>
    implements $DocModelCopyWith<$Res> {
  factory _$$DocModelImplCopyWith(
          _$DocModelImpl value, $Res Function(_$DocModelImpl) then) =
      __$$DocModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String ext,
      String name,
      String module,
      String uploadDate,
      String uploadedBy,
      List<String> like,
      List<String> dislike,
      int downloads});
}

/// @nodoc
class __$$DocModelImplCopyWithImpl<$Res>
    extends _$DocModelCopyWithImpl<$Res, _$DocModelImpl>
    implements _$$DocModelImplCopyWith<$Res> {
  __$$DocModelImplCopyWithImpl(
      _$DocModelImpl _value, $Res Function(_$DocModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? ext = null,
    Object? name = null,
    Object? module = null,
    Object? uploadDate = null,
    Object? uploadedBy = null,
    Object? like = null,
    Object? dislike = null,
    Object? downloads = null,
  }) {
    return _then(_$DocModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      ext: null == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      module: null == module
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String,
      uploadDate: null == uploadDate
          ? _value.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedBy: null == uploadedBy
          ? _value.uploadedBy
          : uploadedBy // ignore: cast_nullable_to_non_nullable
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
class _$DocModelImpl implements _DocModel {
  const _$DocModelImpl(
      {required this.id,
      required this.type,
      required this.ext,
      required this.name,
      required this.module,
      required this.uploadDate,
      required this.uploadedBy,
      final List<String> like = const [],
      final List<String> dislike = const [],
      this.downloads = 0})
      : _like = like,
        _dislike = dislike;

  factory _$DocModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String ext;
  @override
  final String name;
  @override
  final String module;
  @override
  final String uploadDate;
  @override
  final String uploadedBy;
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
    return 'DocModel(id: $id, type: $type, ext: $ext, name: $name, module: $module, uploadDate: $uploadDate, uploadedBy: $uploadedBy, like: $like, dislike: $dislike, downloads: $downloads)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ext, ext) || other.ext == ext) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.module, module) || other.module == module) &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.uploadedBy, uploadedBy) ||
                other.uploadedBy == uploadedBy) &&
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
      type,
      ext,
      name,
      module,
      uploadDate,
      uploadedBy,
      const DeepCollectionEquality().hash(_like),
      const DeepCollectionEquality().hash(_dislike),
      downloads);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocModelImplCopyWith<_$DocModelImpl> get copyWith =>
      __$$DocModelImplCopyWithImpl<_$DocModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocModelImplToJson(
      this,
    );
  }
}

abstract class _DocModel implements DocModel {
  const factory _DocModel(
      {required final String id,
      required final String type,
      required final String ext,
      required final String name,
      required final String module,
      required final String uploadDate,
      required final String uploadedBy,
      final List<String> like,
      final List<String> dislike,
      final int downloads}) = _$DocModelImpl;

  factory _DocModel.fromJson(Map<String, dynamic> json) =
      _$DocModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get ext;
  @override
  String get name;
  @override
  String get module;
  @override
  String get uploadDate;
  @override
  String get uploadedBy;
  @override
  List<String> get like;
  @override
  List<String> get dislike;
  @override
  int get downloads;
  @override
  @JsonKey(ignore: true)
  _$$DocModelImplCopyWith<_$DocModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
