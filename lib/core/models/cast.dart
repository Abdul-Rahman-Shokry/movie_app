import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'character')
  final String? character;

  @JsonKey(name: 'profile_path')
  final String? profilePath;

  Cast({
    required this.id,
    required this.name,
    this.character,
    this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
  Map<String, dynamic> toJson() => _$CastToJson(this);

  String? get fullProfileUrl => profilePath != null
      ? '${AppConstants.tmdbImageBaseUrl}$profilePath'
      : null;
}
