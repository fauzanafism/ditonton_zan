import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/cubit/tv_series_watchlist_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';


class MockGetWatchListStatusTvSeries extends Mock implements GetWatchListTvSeriesStatus {}

class MockSaveWatchlistTvSeries extends Mock implements SaveWatchlistTvSeries {}

class MockRemoveWatchlistTvSeries extends Mock implements RemoveWatchlistTvSeries {}

void main() {
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTV;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTV;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTV;
  late TvSeriesWatchlistStatusCubit watchlistStatusTVCubit;

  setUp(() {
    mockGetWatchListStatusTV = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTV = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTV = MockRemoveWatchlistTvSeries();
    watchlistStatusTVCubit = TvSeriesWatchlistStatusCubit(
      getWatchlistTvSeriesStatus: mockGetWatchListStatusTV,
      saveWatchlistTvSeries: mockSaveWatchlistTV,
      removeWatchlistTvSeries: mockRemoveWatchlistTV,
    );
  });

  const tId = 1;

  group('TV Bloc, Get Watchlist Status TV:', () {
    blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatus>(
      'should get watchlist true',
      build: () {
        when(() => mockGetWatchListStatusTV.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistStatusTVCubit;
      },
      act: (bloc) => bloc.loadWatchlistStatus(tId),
      expect: () => [
        const TvSeriesWatchlistStatus(isAddedWatchlist: true, message: ''),
      ],
    );
  });

  group('TV Bloc, Save Watchlist TV:', () {
    blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatus>(
      'should execute save watchlist when function called',
      build: () {
        when(() => mockSaveWatchlistTV.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(() => mockGetWatchListStatusTV.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchlistStatusTVCubit;
      },
      act: (bloc) => bloc.addWatchlistTV(testTvSeriesDetail),
      expect: () => [
        const TvSeriesWatchlistStatus(
            isAddedWatchlist: true, message: 'Added to Watchlist'),
      ],
    );

    blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatus>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(() => mockSaveWatchlistTV.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchListStatusTV.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return watchlistStatusTVCubit;
      },
      act: (bloc) => bloc.addWatchlistTV(testTvSeriesDetail),
      expect: () => [
        const TvSeriesWatchlistStatus(
            isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });

  group('TV Bloc, Remove Watchlist TV:', () {
    blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatus>(
      'should execute remove watchlist when function called',
      build: () {
        when(() => mockRemoveWatchlistTV.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(() => mockGetWatchListStatusTV.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return watchlistStatusTVCubit;
      },
      act: (bloc) => bloc.removeFromWatchlistTV(testTvSeriesDetail),
      expect: () => [
        const TvSeriesWatchlistStatus(
            isAddedWatchlist: true, message: 'Removed'),
      ],
    );

    blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatus>(
      'should update watchlist message when remove watchlist failed',
      build: () {
        when(() => mockRemoveWatchlistTV.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchListStatusTV.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return watchlistStatusTVCubit;
      },
      act: (bloc) => bloc.removeFromWatchlistTV(testTvSeriesDetail),
      expect: () => [
        const TvSeriesWatchlistStatus(
            isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });
}
