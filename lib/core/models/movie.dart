import 'package:json_annotation/json_annotation.dart';
import '../utils/constants.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'overview')
  final String? overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  Movie({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String? get fullPosterUrl =>
      posterPath != null ? '${AppConstants.tmdbImageBaseUrl}$posterPath' : null;

  String? get fullBackdropUrl => backdropPath != null
      ? '${AppConstants.tmdbImageBaseUrl}$backdropPath'
      : null;
}
