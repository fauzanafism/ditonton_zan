import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc =
        MovieTopRatedBloc(getTopRatedMovies: mockGetTopRatedMovies);
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

  group('Movie Bloc, Top Rated Movie:', () {
    test('initialState should be Empty', () {
      expect(movieTopRatedBloc.state, MovieTopRatedEmptyState());
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      expect: () => [
        MovieTopRatedLoadingState(),
        MovieTopRatedHasDataState(result: tMovieList)
      ],
      verify: (bloc) => verify(() => mockGetTopRatedMovies.execute()),
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      expect: () => [
        MovieTopRatedLoadingState(),
        MovieTopRatedErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetTopRatedMovies.execute()),
    );
  });
}
