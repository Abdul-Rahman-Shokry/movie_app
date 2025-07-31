import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/error_message.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/movie_list_section.dart';
import '../../../core/cubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeCubit>().state == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const LoadingIndicator();
          } else if (state is HomeLoaded) {
            final homeData = state.homeData;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  MovieListSection(
                    title: 'Trending Movies',
                    movies: homeData.trendingMovies,
                  ),
                  const SizedBox(height: 16.0),
                  MovieListSection(
                    title: 'Now Playing',
                    movies: homeData.nowPlayingMovies,
                  ),
                  const SizedBox(height: 16.0),
                  MovieListSection(
                    title: 'Top Rated Movies',
                    movies: homeData.topRatedMovies,
                  ),
                  const SizedBox(height: 16.0),
                  MovieListSection(
                    title: 'Upcoming Movies',
                    movies: homeData.upcomingMovies,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            );
          } else if (state is HomeError) {
            return ErrorMessage(
              message: state.message,
              onRetry: () {
                context.read<HomeCubit>().fetchHomeMovies();
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
