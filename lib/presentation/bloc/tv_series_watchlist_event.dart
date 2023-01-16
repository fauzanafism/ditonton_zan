part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object?> get props => [];
}

class FetchWatchlistTvSeries extends TvSeriesWatchlistEvent {}
