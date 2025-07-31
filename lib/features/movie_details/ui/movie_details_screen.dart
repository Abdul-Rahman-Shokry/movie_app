import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/core/widgets/error_message.dart';
import 'package:movie_app/core/widgets/loading_indicator.dart';
import 'package:movie_app/features/movie_details/cubit/movie_details_state.dart';
import '../cubit/movie_details_cubit.dart';
import '../../../core/cubit/theme_cubit.dart'; // Import ThemeCubit

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  final ApiClient apiClient;

  const MovieDetailsScreen({
    super.key,
    required this.movieId,
    required this.apiClient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieDetailsCubit(apiClient)..fetchMovieDetails(movieId),
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                // Theme toggle icon
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return IconButton(
                      icon: Icon(
                        themeMode == ThemeMode.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                      tooltip: themeMode == ThemeMode.dark
                          ? 'Switch to Light Mode'
                          : 'Switch to Dark Mode',
                    );
                  },
                ),
              ],
            ),
            body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
              builder: (context, state) {
                if (state is MovieDetailsLoading) {
                  return const LoadingIndicator();
                } else if (state is MovieDetailsLoaded) {
                  final movieData = state.movieDetailsData;
                  final details = movieData.details;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              if (details.fullBackdropUrl != null)
                                CachedNetworkImage(
                                  imageUrl: details.fullBackdropUrl!,
                                  width: double.infinity,
                                  height: 300,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const LoadingIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: Colors.grey[800],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.white,
                                        ),
                                      ),
                                ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0.5),
                                      Colors.transparent,
                                      Color.fromRGBO(0, 0, 0, 0.7),
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (details.fullPosterUrl != null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: details.fullPosterUrl!,
                                          width: 120,
                                          height: 180,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const LoadingIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                width: 120,
                                                height: 180,
                                                color: Colors.grey[800],
                                                child: const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.white,
                                                ),
                                              ),
                                        ),
                                      ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            details.title ?? 'N/A',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                color: Colors.amber,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                details.voteAverage
                                                        ?.toStringAsFixed(1) ??
                                                    'N/A',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Colors.white70,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            children: details.genres!
                                                .map(
                                                  (genre) => Chip(
                                                    label: Text(genre.name),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary
                                                            .withOpacity(0.7),
                                                    labelStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overview',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                details.overview ?? 'No overview available.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        if (movieData.credits != null &&
                            movieData.credits!.cast.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cast',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movieData.credits!.cast.length,
                                    itemBuilder: (context, index) {
                                      final castMember =
                                          movieData.credits!.cast[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12.0,
                                        ),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  castMember.fullProfileUrl !=
                                                      null
                                                  ? CachedNetworkImageProvider(
                                                      castMember
                                                          .fullProfileUrl!,
                                                    )
                                                  : null,
                                              backgroundColor: Colors.grey[800],
                                              child:
                                                  castMember.fullProfileUrl ==
                                                      null
                                                  ? const Icon(
                                                      Icons.person,
                                                      size: 50,
                                                      color: Colors.white70,
                                                    )
                                                  : null,
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                castMember.name,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                castMember.character,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: Colors.grey,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (movieData.videos != null &&
                            movieData.videos!.results.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trailers',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movieData.videos!.results.length,
                                    itemBuilder: (context, index) {
                                      final video =
                                          movieData.videos!.results[index];
                                      if (video.site == 'YouTube' &&
                                          video.type == 'Trailer') {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://img.youtube.com/vi/${video.key}/hqdefault.jpg',
                                                width: 240,
                                                height: 180,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          width: 240,
                                                          height: 180,
                                                          color:
                                                              Colors.grey[800],
                                                          child: const Icon(
                                                            Icons.videocam_off,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                              ),
                                              Positioned.fill(
                                                child: Center(
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.play_circle_fill,
                                                      color: Colors.white,
                                                      size: 60,
                                                    ),
                                                    onPressed: () {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Playing trailer for: ${video.name}',
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                } else if (state is MovieDetailsError) {
                  return ErrorMessage(
                    message: state.message,
                    onRetry: () {
                      context.read<MovieDetailsCubit>().fetchMovieDetails(
                        movieId,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
