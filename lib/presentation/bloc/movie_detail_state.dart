part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmptyState extends MovieDetailState {}

class MovieDetailErrorState extends MovieDetailState {
  final String message;

  MovieDetailErrorState(this.message);
}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailHasDataState extends MovieDetailState {
  final MovieDetail result;

  MovieDetailHasDataState({required this.result});
}
