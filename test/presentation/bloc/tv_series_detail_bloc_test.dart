import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTVSeriesDetail extends Mock implements GetTvSeriesDetail {}

void main() {
  late MockGetTVSeriesDetail mockGetTVShowDetail;
  late TvSeriesDetailBloc tvSeriesDetailBloc;

  setUp(() {
    mockGetTVShowDetail = MockGetTVSeriesDetail();
    tvSeriesDetailBloc =
        TvSeriesDetailBloc(getTvSeriesDetail: mockGetTVShowDetail);
  });

  const tId = 1;

  group('TV Bloc, Get TV Show Detail:', () {
    test('initialState should be Empty', () {
      expect(tvSeriesDetailBloc.state, TvSeriesDetailEmptyState());
    });

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetTVShowDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      expect: () => [
        TvSeriesDetailLoadingState(),
        TvSeriesDetailHasDataState(result: testTvSeriesDetail)
      ],
      verify: (bloc) => verify(() => mockGetTVShowDetail.execute(tId)),
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetTVShowDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvSeriesDetail(id: tId)),
      expect: () => [
        TvSeriesDetailLoadingState(),
        TvSeriesDetailErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetTVShowDetail.execute(tId)),
    );
  });
}
