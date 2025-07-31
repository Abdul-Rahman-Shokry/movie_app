import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/core/utils/constants.dart';

part 'crew.g.dart';

@JsonSerializable()
class Crew {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'job')
  final String? job;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  Crew({required this.id, required this.name, this.job, this.profilePath});

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
  Map<String, dynamic> toJson() => _$CrewToJson(this);

  String? get fullProfileUrl => profilePath != null
      ? '${AppConstants.tmdbImageBaseUrl}$profilePath'
      : null;
}
