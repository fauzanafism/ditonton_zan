part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();
  
  @override
  List<Object> get props => [];
}

class MovieTopRatedEmptyState extends MovieTopRatedState {}

class MovieTopRatedLoadingState extends MovieTopRatedState {}

class MovieTopRatedErrorState extends MovieTopRatedState {
  final String message;

  MovieTopRatedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieTopRatedHasDataState extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedHasDataState({required this.result});

  @override
  List<Object> get props => [result];
}


