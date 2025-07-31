import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_client.dart';
import 'package:movie_app/core/models/movie.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ApiClient _apiClient;
  Timer? _debounce; // For debouncing live search suggestions

  SearchCubit(this._apiClient) : super(SearchInitial());

  // Fetches live search suggestions with debouncing
  void fetchSearchSuggestions(String query) {
    print('SearchCubit: fetchSearchSuggestions called with query: "$query"');
    if (query.isEmpty) {
      print('SearchCubit: Query is empty, emitting SearchInitial');
      emit(SearchInitial()); // Or SearchEmpty if you prefer an empty state here
      _debounce?.cancel();
      return;
    }

    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      print('SearchCubit: Debounced search for query: "$query"');
      emit(SearchLoading());
      try {
        final movies = await _apiClient.searchMovies(
          query,
          page: 1,
        ); // Fetch first page
        print('SearchCubit: Search API returned ${movies.length} movies');
        if (movies.isEmpty) {
          print('SearchCubit: No movies found, emitting SearchEmpty');
          emit(SearchEmpty());
        } else {
          print(
            'SearchCubit: Emitting SearchSuggestionsLoaded with ${movies.length} movies',
          );
          emit(SearchSuggestionsLoaded(movies));
        }
      } catch (e) {
        print('SearchCubit: Error in fetchSearchSuggestions: $e');
        emit(SearchError('Failed to load suggestions: ${e.toString()}'));
      }
    });
  }

  // Performs a full search and emits results
  Future<void> performSearch(String query) async {
    print('SearchCubit: performSearch called with query: "$query"');
    if (query.isEmpty) {
      print('SearchCubit: Query is empty, emitting SearchInitial');
      emit(SearchInitial()); // Reset to initial if query is empty
      return;
    }

    _debounce?.cancel(); // Cancel any pending suggestion debounces

    emit(SearchLoading());
    try {
      final movies = await _apiClient.searchMovies(
        query,
        page: 1,
      ); // Fetch first page
      print('SearchCubit: Search API returned ${movies.length} movies');
      if (movies.isEmpty) {
        print('SearchCubit: No movies found, emitting SearchEmpty');
        emit(SearchEmpty());
      } else {
        print(
          'SearchCubit: Emitting SearchResultsLoaded with ${movies.length} movies',
        );
        emit(SearchResultsLoaded(movies));
      }
    } catch (e) {
      print('SearchCubit: Error in performSearch: $e');
      emit(SearchError('Failed to perform search: ${e.toString()}'));
    }
  }

  // Clears the search state
  void clearSearch() {
    print('SearchCubit: clearSearch called');
    _debounce?.cancel();
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
