// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_doc_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteDocModel {
  String? get id;
  String get url;
  @TimestampConverter()
  DateTime? get uploaded;
  String get uid;
  String get size;
  @AccessConverter()
  AccessType get access;
  @CategoryConverter()
  UploadCategory? get type;
  @ModuleConverter()
  List<ModuleModel>? get modules;
  String get name;
  List<String> get like;
  List<String> get dislike;
  int get downloads;

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemoteDocModelCopyWith<RemoteDocModel> get copyWith =>
      _$RemoteDocModelCopyWithImpl<RemoteDocModel>(
          this as RemoteDocModel, _$identity);

  /// Serializes this RemoteDocModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RemoteDocModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploaded, uploaded) ||
                other.uploaded == uploaded) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.modules, modules) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.like, like) &&
            const DeepCollectionEquality().equals(other.dislike, dislike) &&
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
      access,
      type,
      const DeepCollectionEquality().hash(modules),
      name,
      const DeepCollectionEquality().hash(like),
      const DeepCollectionEquality().hash(dislike),
      downloads);

  @override
  String toString() {
    return 'RemoteDocModel(id: $id, url: $url, uploaded: $uploaded, uid: $uid, size: $size, access: $access, type: $type, modules: $modules, name: $name, like: $like, dislike: $dislike, downloads: $downloads)';
  }
}

/// @nodoc
abstract mixin class $RemoteDocModelCopyWith<$Res> {
  factory $RemoteDocModelCopyWith(
          RemoteDocModel value, $Res Function(RemoteDocModel) _then) =
      _$RemoteDocModelCopyWithImpl;
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
class _$RemoteDocModelCopyWithImpl<$Res>
    implements $RemoteDocModelCopyWith<$Res> {
  _$RemoteDocModelCopyWithImpl(this._self, this._then);

  final RemoteDocModel _self;
  final $Res Function(RemoteDocModel) _then;

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
    Object? access = null,
    Object? type = freezed,
    Object? modules = freezed,
    Object? name = null,
    Object? like = null,
    Object? dislike = null,
    Object? downloads = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploaded: freezed == uploaded
          ? _self.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      access: null == access
          ? _self.access
          : access // ignore: cast_nullable_to_non_nullable
              as AccessType,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as UploadCategory?,
      modules: freezed == modules
          ? _self.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      like: null == like
          ? _self.like
          : like // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dislike: null == dislike
          ? _self.dislike
          : dislike // ignore: cast_nullable_to_non_nullable
              as List<String>,
      downloads: null == downloads
          ? _self.downloads
          : downloads // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RemoteDocModel extends RemoteDocModel {
  const _RemoteDocModel(
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
  factory _RemoteDocModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteDocModelFromJson(json);

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

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemoteDocModelCopyWith<_RemoteDocModel> get copyWith =>
      __$RemoteDocModelCopyWithImpl<_RemoteDocModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RemoteDocModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RemoteDocModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.uploaded, uploaded) ||
                other.uploaded == uploaded) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.type, type) || other.type == type) &&
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
      access,
      type,
      const DeepCollectionEquality().hash(_modules),
      name,
      const DeepCollectionEquality().hash(_like),
      const DeepCollectionEquality().hash(_dislike),
      downloads);

  @override
  String toString() {
    return 'RemoteDocModel(id: $id, url: $url, uploaded: $uploaded, uid: $uid, size: $size, access: $access, type: $type, modules: $modules, name: $name, like: $like, dislike: $dislike, downloads: $downloads)';
  }
}

/// @nodoc
abstract mixin class _$RemoteDocModelCopyWith<$Res>
    implements $RemoteDocModelCopyWith<$Res> {
  factory _$RemoteDocModelCopyWith(
          _RemoteDocModel value, $Res Function(_RemoteDocModel) _then) =
      __$RemoteDocModelCopyWithImpl;
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
class __$RemoteDocModelCopyWithImpl<$Res>
    implements _$RemoteDocModelCopyWith<$Res> {
  __$RemoteDocModelCopyWithImpl(this._self, this._then);

  final _RemoteDocModel _self;
  final $Res Function(_RemoteDocModel) _then;

  /// Create a copy of RemoteDocModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? url = null,
    Object? uploaded = freezed,
    Object? uid = null,
    Object? size = null,
    Object? access = null,
    Object? type = freezed,
    Object? modules = freezed,
    Object? name = null,
    Object? like = null,
    Object? dislike = null,
    Object? downloads = null,
  }) {
    return _then(_RemoteDocModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      uploaded: freezed == uploaded
          ? _self.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      access: null == access
          ? _self.access
          : access // ignore: cast_nullable_to_non_nullable
              as AccessType,
      type: freezed == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as UploadCategory?,
      modules: freezed == modules
          ? _self._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleModel>?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      like: null == like
          ? _self._like
          : like // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dislike: null == dislike
          ? _self._dislike
          : dislike // ignore: cast_nullable_to_non_nullable
              as List<String>,
      downloads: null == downloads
          ? _self.downloads
          : downloads // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
