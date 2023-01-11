import 'dart:convert';

import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/episode_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
      airDate: '2020-01-01',
      episodeNumber: 3,
      id: 321,
      name: 'name',
      overview: 'overview',
      productionCode: '',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 51);
  final tEpisodeResponseModel = EpisodeResponse(episodes: [tEpisodeModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/episode.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponseModel);
    });
  });
}
