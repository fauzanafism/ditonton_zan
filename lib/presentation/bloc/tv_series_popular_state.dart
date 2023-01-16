part of 'tv_series_popular_bloc.dart';

@immutable
abstract class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();

  @override
  List<Object?> get props => [];
}

class TvSeriesPopularEmptyState extends TvSeriesPopularState {}

class TvSeriesPopularLoadingState extends TvSeriesPopularState {}

class TvSeriesPopularHasDataState extends TvSeriesPopularState {
  final List<TvSeries> result;

  const TvSeriesPopularHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}

class TvSeriesPopularErrorState extends TvSeriesPopularState {
  final String message;

  const TvSeriesPopularErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}