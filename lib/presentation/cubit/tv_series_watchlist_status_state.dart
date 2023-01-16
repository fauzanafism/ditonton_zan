part of 'tv_series_watchlist_status_cubit.dart';

class TvSeriesWatchlistStatus extends Equatable {
  final bool isAddedWatchlist;
  final String message;

  const TvSeriesWatchlistStatus({
    required this.isAddedWatchlist,
    required this.message,
  });

  @override
  List<Object> get props => [isAddedWatchlist];
}
