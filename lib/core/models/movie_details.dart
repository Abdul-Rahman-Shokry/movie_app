import 'package:json_annotation/json_annotation.dart';
import 'genre.dart';
import '../utils/constants.dart';

part 'movie_details.g.dart';

@JsonSerializable()
class MovieDetails {
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

  @JsonKey(name: 'runtime')
  final int? runtime; // In minutes

  @JsonKey(name: 'genres')
  final List<Genre>? genres;

  // Constructor
  MovieDetails({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.releaseDate,
    this.runtime,
    this.genres,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  String? get fullPosterUrl =>
      posterPath != null ? '${AppConstants.tmdbImageBaseUrl}$posterPath' : null;

  String? get fullBackdropUrl => backdropPath != null
      ? '${AppConstants.tmdbImageBaseUrl}$backdropPath'
      : null;

  String get formattedRuntime {
    if (runtime == null) return 'N/A';
    final hours = runtime! ~/ 60;
    final minutes = runtime! % 60;
    return '${hours}h ${minutes}m';
  }

  String get genresString {
    if (genres == null || genres!.isEmpty) return 'N/A';
    return genres!.map((e) => e.name).join(', ');
  }
}
