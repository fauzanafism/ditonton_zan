import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: [1, 2, 3],
      id: 3,
      name: 'name',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.1,
      posterPath: 'posterPath',
      voteAverage: 8.8,
      voteCount: 3);

  final tTvSeries = TvSeries(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: [1, 2, 3],
      id: 3,
      name: 'name',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.1,
      posterPath: 'posterPath',
      voteAverage: 8.8,
      voteCount: 3);

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
