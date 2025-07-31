// lib/features/home/ui/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/models/movie.dart';
import '../../../core/network/api_client.dart'; // Ensure ApiClient is imported
import '../../../core/router/app_router.dart';
import '../../../core/widgets/error_message.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../search/cubit/search_cubit.dart'; // Import the new SearchCubit
import '../../search/cubit/search_state.dart'; // Import the new SearchState
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../../../core/cubit/theme_cubit.dart'; // Import ThemeCubit
import 'widgets/movie_list_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        // Clear search state when closing search
        if (context.mounted) {
          context.read<SearchCubit>().clearSearch();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            _searchController.clear();
                            context.read<SearchCubit>().clearSearch();
                          },
                        )
                      : null,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  context.read<SearchCubit>().fetchSearchSuggestions(query);
                },
                onSubmitted: (query) {
                  context.read<SearchCubit>().performSearch(query);
                },
              )
            : const Text('MovieApp'), // Your app title
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
          // Search icon
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: _isSearching
          ? BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                print('Search State: $state'); // Debug print
                if (state is SearchLoading) {
                  return const LoadingIndicator();
                } else if (state is SearchInitial) {
                  return Center(
                    child: Text(
                      'Start typing to search for movies...',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (state is SearchSuggestionsLoaded) {
                  print(
                    'Search Suggestions: ${state.suggestions.length}',
                  ); // Debug print
                  return _buildMovieList(
                    'Suggestions',
                    state.suggestions,
                    context,
                  );
                } else if (state is SearchResultsLoaded) {
                  print(
                    'Search Results: ${state.results.length}',
                  ); // Debug print
                  return _buildMovieList(
                    'Search Results',
                    state.results,
                    context,
                  );
                } else if (state is SearchEmpty) {
                  return Center(
                    child: Text(
                      'No movies found for "${_searchController.text}"',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (state is SearchError) {
                  return ErrorMessage(
                    message: state.message,
                    onRetry: () {
                      if (_searchController.text.isNotEmpty) {
                        context.read<SearchCubit>().performSearch(
                          _searchController.text,
                        );
                      } else {
                        context.read<SearchCubit>().clearSearch();
                      }
                    },
                  );
                }
                return const SizedBox.shrink(); // Fallback for unhandled states
              },
            )
          : BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const LoadingIndicator();
                } else if (state is HomeLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MovieListSection(
                          title: 'Popular Movies',
                          movies: state.popularMovies,
                        ),
                        MovieListSection(
                          title: 'Trending Movies',
                          movies: state.trendingMovies,
                        ),
                        MovieListSection(
                          title: 'Upcoming Movies',
                          movies: state.upcomingMovies,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                } else if (state is HomeError) {
                  return ErrorMessage(
                    message: state.message,
                    onRetry: () {
                      context.read<HomeCubit>().fetchHomeData();
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
    );
  }

  Widget _buildMovieList(
    String title,
    List<Movie> movies,
    BuildContext context,
  ) {
    print(
      'Building movie list: $title with ${movies.length} movies',
    ); // Debug print
    if (movies.isEmpty) {
      return Center(
        child: Text(
          'No ${title.toLowerCase()} found.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }
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
        Expanded(
          // Use Expanded inside a Column in the body to allow ListView to take available space
          child: GridView.builder(
            // Changed to GridView for better display of search results
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6, // Adjust as needed for poster proportions
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(AppRouter.movieDetailsRoute, arguments: movie.id);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: movie.fullPosterUrl != null
                            ? Image.network(
                                movie.fullPosterUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.white70,
                                      ),
                                    ),
                              )
                            : Container(
                                color: Colors.grey,
                                child: const Icon(
                                  Icons.movie,
                                  color: Colors.white70,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall, // Smaller font for grid
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
