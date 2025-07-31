import 'package:flutter/material.dart';
import '../../../../core/models/movie.dart';

class MovieListSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieListSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 200,
          child: movies.isEmpty
              ? Center(
                  child: Text(
                    'No movies available.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          print('Tapped on: ${movie.title}');
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: movie.fullPosterUrl != null
                                  ? Image.network(
                                      movie.fullPosterUrl!,
                                      width: 120,
                                      height: 160,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                width: 120,
                                                height: 160,
                                                color: Colors.grey,
                                                child: const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                    )
                                  : Container(
                                      width: 120,
                                      height: 160,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.movie,
                                        color: Colors.white70,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              width: 120,
                              height: 32,
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
