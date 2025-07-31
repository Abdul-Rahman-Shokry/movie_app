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
}
