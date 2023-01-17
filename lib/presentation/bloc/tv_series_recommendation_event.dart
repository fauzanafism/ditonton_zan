part of 'tv_series_recommendation_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecommendationTvSeries extends RecommendationTvEvent {
  final int id;

  const FetchRecommendationTvSeries({required this.id});

  @override
  List<Object?> get props => [id];
}
