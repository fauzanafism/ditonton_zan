part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmptyState extends MovieRecommendationState {}

class MovieRecommendationLoadingState extends MovieRecommendationState {}

class MovieRecommendationErrorState extends MovieRecommendationState {
  final String message;

  MovieRecommendationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasDataState extends MovieRecommendationState {
  final List<Movie> result;

  MovieRecommendationHasDataState({required this.result});

  @override
  List<Object> get props => [result];
}
