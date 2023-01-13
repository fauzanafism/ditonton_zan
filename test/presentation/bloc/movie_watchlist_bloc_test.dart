import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MovieWatchlistBloc movieWatchlistBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchlistBloc =
        MovieWatchlistBloc(getWatchlistMovies: mockGetWatchlistMovies);
  });

  group('Movie Bloc, Watchlist Movie:', () {
    test('initialState should be Empty', () {
      expect(movieWatchlistBloc.state, MovieWatchlistEmptyState());
    });

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        MovieWatchlistLoadingState(),
        MovieWatchlistHasDataState(result: [testWatchlistMovie])
      ],
      verify: (bloc) => verify(() => mockGetWatchlistMovies.execute()),
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => Left(DatabaseFailure("Can't get data")));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        MovieWatchlistLoadingState(),
        MovieWatchlistErrorState(message: "Can't get data"),
      ],
      verify: (bloc) => verify(() => mockGetWatchlistMovies.execute()),
    );
  });
}
