import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(getPopularMovies: mockGetPopularMovies);
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

  group('Movie Bloc, Popular Movie:', () {
    test('initialState should be Empty', () {
      expect(moviePopularBloc.state, MoviePopularEmptyState());
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MoviePopularLoadingState(),
        MoviePopularHasDataState(result: tMovieList)
      ],
      verify: (bloc) => verify(() => mockGetPopularMovies.execute()),
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        MoviePopularLoadingState(),
        MoviePopularErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetPopularMovies.execute()),
    );
  });
}
