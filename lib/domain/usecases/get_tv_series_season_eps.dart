import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesSeasonEpisodes {
  final TvSeriesRepository repository;

  GetTvSeriesSeasonEpisodes(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return repository.getTvSeriesSeasonEpisodes(id, seasonNumber);
  }
}
