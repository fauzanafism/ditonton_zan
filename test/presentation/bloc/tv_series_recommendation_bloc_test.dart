import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/presentation/bloc/tv_series_recommendation_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTVSeriesRecommendation extends Mock
    implements GetTvSeriesRecommendation {}

void main() {
  late MockGetTVSeriesRecommendation mockGetTVShowsRecommendation;
  late TvSeriesRecommendationBloc recommendationTVBloc;

  setUp(() {
    mockGetTVShowsRecommendation = MockGetTVSeriesRecommendation();
    recommendationTVBloc = TvSeriesRecommendationBloc(
        getTvSeriesRecommendation: mockGetTVShowsRecommendation);
  });

  const tId = 1;
  final tTVShow = TvSeries(
      backdropPath: '/tE6dWq9neq2IPSc6kJQdxyMrl7w.jpg',
      firstAirDate: '2022-08-15',
      genreIds: [10759, 10765, 18],
      id: 121750,
      name: 'Darna',
      originalName: 'Darna',
      overview:
          "When fragments of a green crystal scatter in the city and turn people into destructive monsters, Narda embraces her destiny as Darna—the mighty protector of the powerful stone from Planet Marte.",
      popularity: 909.96,
      posterPath: "/CFOce6pbb3FRNaBaVdvNsCv5kR.jpg",
      voteAverage: 4.8,
      voteCount: 12);

  final tTVShowsList = <TvSeries>[tTVShow];

  group('TV Bloc, Get Recommendation TV Shows:', () {
    test('initialState should be Empty', () {
      expect(recommendationTVBloc.state, TvSeriesRecommendationEmptyState());
    });

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetTVShowsRecommendation.execute(tId))
            .thenAnswer((_) async => Right(tTVShowsList));
        return recommendationTVBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTvShow(id: tId)),
      expect: () => [
        TvSeriesRecommendationLoadingState(),
        TvSeriesRecommendationHasDataState(result: tTVShowsList)
      ],
      verify: (bloc) => verify(() => mockGetTVShowsRecommendation.execute(tId)),
    );

    blocTest<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetTVShowsRecommendation.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recommendationTVBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendationTvShow(id: tId)),
      expect: () => [
        TvSeriesRecommendationLoadingState(),
        const TvSeriesRecommendationErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetTVShowsRecommendation.execute(tId)),
    );
  });
}
