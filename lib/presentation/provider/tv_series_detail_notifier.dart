import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation getTvSeriesRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late TvSeriesDetail _movie;
  TvSeriesDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<TvSeries> _movieRecommendations = [];
  List<TvSeries> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
