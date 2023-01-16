part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object?> get props => [];
}

class TvSeriesWatchlistEmptyState extends TvSeriesWatchlistState {}

class TvSeriesWatchlistLoadingState extends TvSeriesWatchlistState {}

class TvSeriesWatchlistHasDataState extends TvSeriesWatchlistState {
  final List<TvSeries> result;

  const TvSeriesWatchlistHasDataState({required this.result});

  @override
  List<Object?> get props => [result];
}

class TvSeriesWatchlistErrorState extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
