// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String?,
      names: json['names'] as String?,
      surname: json['surname'] as String?,
      classId: json['classId'] as String?,
      type: json['type'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'names': instance.names,
      'surname': instance.surname,
      'classId': instance.classId,
      'type': instance.type,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
