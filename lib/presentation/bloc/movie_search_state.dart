part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchEmptyState extends MovieSearchState {}

class MovieSearchLoadingState extends MovieSearchState {}

class MovieSearchErrorState extends MovieSearchState {
  final String message;

  MovieSearchErrorState({required this.message});
}

class MovieSearchHasDataState extends MovieSearchState {
  final List<Movie> result;

  MovieSearchHasDataState({required this.result});
}
