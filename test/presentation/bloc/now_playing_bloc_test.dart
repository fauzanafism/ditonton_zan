import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc =
        NowPlayingBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('Movie Bloc, Now Playing Movie:', () {
    test('initialState should be Empty', () {
      expect(nowPlayingMovieBloc.state, NowPlayingEmptyState());
    });

    blocTest<NowPlayingBloc, NowPlayingState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovie()),
      expect: () => [
        NowPlayingLoadingState(),
        NowPlayingHasDataState(result: tMovieList)
      ],
      verify: (bloc) => verify(() => mockGetNowPlayingMovies.execute()),
    );

    blocTest<NowPlayingBloc, NowPlayingState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovie()),
      expect: () => [
        NowPlayingLoadingState(),
        NowPlayingErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetNowPlayingMovies.execute()),
    );
  });
}
