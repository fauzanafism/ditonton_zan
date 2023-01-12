import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  const tId = 1;

  group('Movie Detail Bloc:', () {
    test('initialState should be Empty', () {
      expect(movieDetailBloc.state, MovieDetailEmptyState());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, HasData] when success',
      build: () {
        when(() => mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailHasDataState(result: testMovieDetail)
      ],
      verify: (bloc) => verify(() => mockGetMovieDetail.execute(tId)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(id: tId)),
      expect: () => [
        MovieDetailLoadingState(),
        MovieDetailErrorState('Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetMovieDetail.execute(tId)),
    );
  });
}
