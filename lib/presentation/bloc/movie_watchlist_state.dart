part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistEmptyState extends MovieWatchlistState {}

class MovieWatchlistLoadingState extends MovieWatchlistState {}

class MovieWatchlistErrorState extends MovieWatchlistState {
  final String message;

  MovieWatchlistErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasDataState extends MovieWatchlistState {
  final List<Movie> result;

  MovieWatchlistHasDataState({required this.result});

  @override
  List<Object> get props => [result];
}
