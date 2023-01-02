import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeriess();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeriess();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeriess();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<Episode>>> getTvSeriesSeasonEpisodes(
      int id, int seasonNumber);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeriess(String query);
  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlistTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeriess();
}