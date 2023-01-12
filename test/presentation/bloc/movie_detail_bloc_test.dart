import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMovieBloc detailMovieBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(getMovieDetail: mockGetMovieDetail);
  });

  const tId = 1;

  group('Movie Detail Bloc:', () {
    test('initialState should be Empty', () {
      expect(detailMovieBloc.state, DetailMovieEmptyState());
    });

    blocTest<DetailMovieBloc, DetailMovieState>(
      'should emit [Loading, HasData] when success',
      build: () {
        when(() => mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const FetchNowDetailMovie(id: tId)),
      expect: () => [
        DetailMovieLoadingState(),
        const DetailMovieHasDataState(result: testMovieDetail)
      ],
      verify: (bloc) => verify(() => mockGetMovieDetail.execute(tId)),
    );

    blocTest<DetailMovieBloc, DetailMovieState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(const FetchNowDetailMovie(id: tId)),
      expect: () => [
        DetailMovieLoadingState(),
        const DetailMovieErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetMovieDetail.execute(tId)),
    );
  });
}
