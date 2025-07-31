import 'package:equatable/equatable.dart';
import '../../../core/models/movie.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuggestionsLoaded extends SearchState {
  final List<Movie> suggestions;
  const SearchSuggestionsLoaded(this.suggestions);

  @override
  List<Object> get props => [suggestions];
}

class SearchResultsLoaded extends SearchState {
  final List<Movie> results;
  const SearchResultsLoaded(this.results);

  @override
  List<Object> get props => [results];
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchEmpty
    extends SearchState {} // State for when no results/suggestions are found
