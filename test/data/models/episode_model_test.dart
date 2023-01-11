import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
      airDate: '2020-01-01',
      episodeNumber: 3,
      id: 321,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1);

  final tEpisode = Episode(
      airDate: '2020-01-01',
      episodeNumber: 3,
      id: 321,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1);

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}
