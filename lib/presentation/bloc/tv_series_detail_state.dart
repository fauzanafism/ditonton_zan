part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailEmptyState extends TvSeriesDetailState {}

class TvSeriesDetailLoadingState extends TvSeriesDetailState {}

class TvSeriesDetailErrorState extends TvSeriesDetailState {
  final String message;

  TvSeriesDetailErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailHasDataState extends TvSeriesDetailState {
  final TvSeriesDetail result;

  TvSeriesDetailHasDataState({required this.result});

  @override
  List<Object> get props => [result];
}
