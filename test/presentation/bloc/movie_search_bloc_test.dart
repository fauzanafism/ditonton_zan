import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late MovieSearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group('Movie Bloc, Search Movie:', () {
    test('initial state should be empty', () {
      expect(searchBloc.state, MovieSearchEmptyState());
    });

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, HasData] when data success',
      build: () {
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoadingState(),
        MovieSearchHasDataState(result: tMovieList),
      ],
      verify: (bloc) {
        verify(() => mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoadingState(),
        MovieSearchErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) {
        verify(() => mockSearchMovies.execute(tQuery));
      },
    );
  });
}
