import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
      backdropPath: "/path.jpg",
      genreIds: [1, 2, 3, 4],
      id: 1,
      originalName: "Original Title",
      overview: "Overview",
      popularity: 1.0,
      posterPath: "/path.jpg",
      firstAirDate: "2020-05-05",
      name: "Title",
      voteAverage: 1.0,
      voteCount: 1);

  final tTvSeries = TvSeries(
      backdropPath: "/path.jpg",
      genreIds: [1, 2, 3, 4],
      id: 1,
      originalName: "Original Title",
      overview: "Overview",
      popularity: 1.0,
      posterPath: "/path.jpg",
      firstAirDate: "2020-05-05",
      name: "Title",
      voteAverage: 1.0,
      voteCount: 1);

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Airing today TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return SSLFailure when certificate doesnt match', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
    });
  });

  group('Popular TV Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test('should return SSLFailure when certificate doesnt match', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
    });
  });

  group('Top Rated TV Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test('should return SSLFailure when certificate doesnt match', () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvSeriesResponse = TvSeriesDetailResponse(
        backdropPath: "/hoVuI69nygLQBJ4FqgRKnukDeKt.jpg",
        episodeRunTime: [],
        firstAirDate: "2022-12-25",
        genres: [
          GenreModel(id: 10759, name: "Action & Adventure"),
          GenreModel(id: 10765, name: "Sci-Fi & Fantasy")
        ],
        homepage: "https://www.netflix.com/title/81279312",
        id: 106541,
        inProduction: false,
        lastAirDate: "2022-12-25",
        name: "The Witcher: Blood Origin",
        numberOfEpisodes: 4,
        numberOfSeasons: 1,
        originalName: "The Witcher: Blood Origin",
        overview:
            "More than a thousand years before the world of The Witcher, seven outcasts in the elven world unite in a blood quest against an unstoppable power.",
        popularity: 1377.633,
        posterPath: "/vpfJK9F0UJNcAIIeC42oJyKMnZQ.jpg",
        seasons: [
          SeasonModel(
              airDate: "2022-12-25",
              episodeCount: 4,
              id: 157411,
              name: "Limited Series",
              overview: "",
              posterPath: "/49WEpzSvhz2KoPNblU3FT2gVbzP.jpg",
              seasonNumber: 1)
        ],
        status: "Ended",
        tagline: "Every story has a beginning.",
        type: "Miniseries",
        voteAverage: 6.465,
        voteCount: 185);

    test(
        'should return tv series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return SSLFailure when certificate doesnt match', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return SSLFailure when certificate doesnt match', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'test';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });

    test('should return SSLFailure when certificate doesnt match', () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(TlsException('CERTIFICATE_VERIFY_FAILED'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(SSLFailure('CERTIFICATE_VERIFY_FAILED')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvSeries(
              TvSeriesTable.fromEntity(testTvSeriesDetail)))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvSeries(
              TvSeriesTable.fromEntity(testTvSeriesDetail)))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvSeries(
              TvSeriesTable.fromEntity(testTvSeriesDetail)))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result =
          await repository.removeWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvSeries(
              TvSeriesTable.fromEntity(testTvSeriesDetail)))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result =
          await repository.removeWatchlistTvSeries(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTvSeries(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
