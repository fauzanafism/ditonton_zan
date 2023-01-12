import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(
        getMovieRecommendations: mockGetMovieRecommendations);
  });

  const tId = 1;
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
  final tMovies = <Movie>[tMovie];

  group('Movie Bloc, Recommendation Movie', () {
    test('initialState should be Empty', () {
      expect(movieRecommendationBloc.state, MovieRecommendationEmptyState());
    });

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit[Loading, HasData] when data success',
      build: () {
        when(() => mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendationMovie(id: tId)),
      expect: () => [
        MovieRecommendationLoadingState(),
        MovieRecommendationHasDataState(result: tMovies)
      ],
      verify: (bloc) => verify(() => mockGetMovieRecommendations.execute(tId)),
    );

    blocTest<MovieRecommendationBloc, MovieRecommendationState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieRecommendationBloc;
      },
      act: (bloc) => bloc.add(FetchRecommendationMovie(id: tId)),
      expect: () => [
        MovieRecommendationLoadingState(),
        MovieRecommendationErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetMovieRecommendations.execute(tId)),
    );
  });
}
