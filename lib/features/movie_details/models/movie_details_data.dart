import '../../../core/models/movie_details.dart';
import '../../../core/models/cast.dart';
import '../../../core/models/crew.dart';

class MovieDetailsData {
  final MovieDetails details;
  final List<Cast> cast;
  final List<Crew> crew;
  final String? trailerKey; // YouTube video key

  MovieDetailsData({
    required this.details,
    this.cast = const [],
    this.crew = const [],
    this.trailerKey,
  });

  get videos => null;

  get credits => null;

  MovieDetailsData copyWith({
    MovieDetails? details,
    List<Cast>? cast,
    List<Crew>? crew,
    String? trailerKey,
  }) {
    return MovieDetailsData(
      details: details ?? this.details,
      cast: cast ?? this.cast,
      crew: crew ?? this.crew,
      trailerKey: trailerKey ?? this.trailerKey,
    );
  }

  static Future<MovieDetailsData> fromJson(Map<String, dynamic> json) async {
    final movieDetails = MovieDetails.fromJson(json);

    List<Cast> cast = [];
    if (json['credits'] != null && json['credits']['cast'] != null) {
      cast = (json['credits']['cast'] as List)
          .map((e) => Cast.fromJson(e))
          .toList();
    }

    List<Crew> crew = [];
    if (json['credits'] != null && json['credits']['crew'] != null) {
      crew = (json['credits']['crew'] as List)
          .map((e) => Crew.fromJson(e))
          .toList();
    }

    String? trailerKey;
    if (json['videos'] != null && json['videos']['results'] != null) {
      final youtubeVideos = (json['videos']['results'] as List)
          .where((e) => e['site'] == 'YouTube' && e['type'] == 'Trailer')
          .toList();
      if (youtubeVideos.isNotEmpty) {
        trailerKey = youtubeVideos.first['key'];
      }
    }
    return MovieDetailsData(
      details: movieDetails,
      cast: cast,
      crew: crew,
      trailerKey: trailerKey,
    );
  }
}
