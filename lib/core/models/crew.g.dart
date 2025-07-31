// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  job: json['job'] as String?,
  profilePath: json['profile_path'] as String?,
);

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'job': instance.job,
  'profile_path': instance.profilePath,
};
