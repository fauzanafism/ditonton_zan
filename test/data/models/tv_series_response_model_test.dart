import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      backdropPath: '/path.jpg',
      firstAirDate: '2020-05-05',
      genreIds: [1, 2, 3, 4],
      id: 1,
      name: 'Title',
      originalName: 'Original Title',
      overview: 'Overview',
      popularity: 1.0,
      posterPath: '/path.jpg',
      voteAverage: 1.0,
      voteCount: 1);

  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/path.jpg',
            'first_air_date': '2020-05-05',
            'genre_ids': [1, 2, 3, 4],
            'id': 1,
            'name': 'Title',
            'original_name': 'Original Title',
            'overview': 'Overview',
            'popularity': 1.0,
            'poster_path': '/path.jpg',
            'vote_average': 1.0,
            'vote_count': 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
