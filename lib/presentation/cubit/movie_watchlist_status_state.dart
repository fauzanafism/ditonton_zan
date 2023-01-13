part of 'movie_watchlist_status_cubit.dart';

class MovieWatchlistStatusState extends Equatable {
  final bool isAddedWatchlist;
  final String message;
  const MovieWatchlistStatusState(
      {required this.isAddedWatchlist, required this.message});

  @override
  List<Object> get props => [isAddedWatchlist];
}
