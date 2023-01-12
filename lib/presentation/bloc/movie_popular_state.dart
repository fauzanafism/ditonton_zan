part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class MoviePopularEmptyState extends MoviePopularState {}

class MoviePopularLoadingState extends MoviePopularState {}

class MoviePopularErrorState extends MoviePopularState {
  final String message;

  MoviePopularErrorState({required this.message});
}

class MoviePopularHasDataState extends MoviePopularState {
  final List<Movie> result;

  MoviePopularHasDataState({required this.result});
}
