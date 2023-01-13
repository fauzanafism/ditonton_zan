part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();
  
  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {}
