part of 'tv_series_recommendation_bloc.dart';


abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object?> get props => [];
}

class TvSeriesRecommendationEmptyState extends TvSeriesRecommendationState {}

class TvSeriesRecommendationLoadingState extends TvSeriesRecommendationState {}

class TvSeriesRecommendationHasDataState extends TvSeriesRecommendationState {
  final List<TvSeries> result;

  const TvSeriesRecommendationHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}

class TvSeriesRecommendationErrorState extends TvSeriesRecommendationState {
  final String message;

  const TvSeriesRecommendationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}