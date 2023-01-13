import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/presentation/cubit/movie_watchlist_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatus extends Mock implements GetWatchListMovieStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlistMovie {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlistMovie {}

void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieWatchlistStatusCubit movieWatchlistStatusCubit;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistStatusCubit = MovieWatchlistStatusCubit(
      getWatchListMovieStatus: mockGetWatchListStatus,
      saveWatchlistMovie: mockSaveWatchlist,
      removeWatchlistMovie: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Movie Bloc, Watchlist Status Movie:', () {
    blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
      'should get watchlist true',
      build: () {
        when(() => mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => true);
        return movieWatchlistStatusCubit;
      },
      act: (bloc) => bloc.loadWatchlistStatus(tId),
      expect: () => [
        const MovieWatchlistStatusState(isAddedWatchlist: true, message: ''),
      ],
    );
  });

  group('Movie Bloc, Save Watchlist Movie:', () {
    blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
      'should execute save watchlist when function called',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieWatchlistStatusCubit;
      },
      act: (bloc) => bloc.addWatchlistMovie(testMovieDetail),
      expect: () => [
        const MovieWatchlistStatusState(
            isAddedWatchlist: true, message: 'Added to Watchlist'),
      ],
    );

    blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieWatchlistStatusCubit;
      },
      act: (bloc) => bloc.addWatchlistMovie(testMovieDetail),
      expect: () => [
        const MovieWatchlistStatusState(
            isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });

  group('Movie Bloc, Remove Watchlist Movie:', () {
    blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
      'should execute remove watchlist when function called',
      build: () {
        when(() => mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieWatchlistStatusCubit;
      },
      act: (bloc) => bloc.removeFromWatchlistMovie(testMovieDetail),
      expect: () => [
        const MovieWatchlistStatusState(
            isAddedWatchlist: true, message: 'Removed'),
      ],
    );

    blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
      'should update watchlist message when remove watchlist failed',
      build: () {
        when(() => mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieWatchlistStatusCubit;
      },
      act: (bloc) => bloc.removeFromWatchlistMovie(testMovieDetail),
      expect: () => [
        MovieWatchlistStatusState(isAddedWatchlist: false, message: 'Failed'),
      ],
    );
  });
}
