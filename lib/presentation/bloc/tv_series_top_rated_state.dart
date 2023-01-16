part of 'tv_series_top_rated_bloc.dart';

abstract class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();

  @override
  List<Object?> get props => [];
}

class TvSeriesTopRatedEmptyState extends TvSeriesTopRatedState {}

class TvSeriesTopRatedLoadingState extends TvSeriesTopRatedState {}

class TvSeriesTopRatedErrorState extends TvSeriesTopRatedState {
  final String message;

  const TvSeriesTopRatedErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class TvSeriesTopRatedHasDataState extends TvSeriesTopRatedState {
  final List<TvSeries> result;

  const TvSeriesTopRatedHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}
