// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  character: json['character'] as String?,
  profilePath: json['profile_path'] as String?,
);

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'character': instance.character,
  'profile_path': instance.profilePath,
};
