import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusCubit extends Cubit<TvSeriesWatchlistStatus> {
  final GetWatchListTvSeriesStatus getWatchlistTvSeriesStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvSeriesWatchlistStatusCubit({
    required this.getWatchlistTvSeriesStatus,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(
            const TvSeriesWatchlistStatus(isAddedWatchlist: false, message: ''));

  void loadWatchlistStatus(int id) async {
    final result = await getWatchlistTvSeriesStatus.execute(id);
    emit(TvSeriesWatchlistStatus(isAddedWatchlist: result, message: ''));
  }

  Future<void> addWatchlistTV(TvSeriesDetail tvDetail) async {
    final result = await saveWatchlistTvSeries.execute(tvDetail);
    final getStatus = await getWatchlistTvSeriesStatus.execute(tvDetail.id);

    result.fold(
      (failure) => emit(TvSeriesWatchlistStatus(
          isAddedWatchlist: getStatus, message: failure.message)),
      (data) => emit(
          TvSeriesWatchlistStatus(isAddedWatchlist: getStatus, message: data)),
    );
  }

  Future<void> removeFromWatchlistTV(TvSeriesDetail tvDetail) async {
    final result = await removeWatchlistTvSeries.execute(tvDetail);
    final getStatus = await getWatchlistTvSeriesStatus.execute(tvDetail.id);

    result.fold(
      (failure) => emit(TvSeriesWatchlistStatus(
          isAddedWatchlist: getStatus, message: failure.message)),
      (data) => emit(
          TvSeriesWatchlistStatus(isAddedWatchlist: getStatus, message: data)),
    );
  }
}
