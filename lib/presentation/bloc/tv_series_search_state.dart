part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object?> get props => [];
}

class TvSeriesSearchEmptyState extends TvSeriesSearchState {}

class TvSeriesSearchLoadingState extends TvSeriesSearchState {}

class TvSeriesSearchHasDataState extends TvSeriesSearchState {
  final List<TvSeries> result;

  const TvSeriesSearchHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}

class TvSeriesSearchErrorState extends TvSeriesSearchState {
  final String message;

  const TvSeriesSearchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}