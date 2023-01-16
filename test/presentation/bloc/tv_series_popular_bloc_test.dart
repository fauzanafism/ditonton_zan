import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularTVShows extends Mock implements GetPopularTvSeries {}

void main() {
  late MockGetPopularTVShows mockGetPopularTVShows;
  late TvSeriesPopularBloc popularTVBloc;

  setUp(() {
    mockGetPopularTVShows = MockGetPopularTVShows();
    popularTVBloc = TvSeriesPopularBloc(getPopularTvSeries: mockGetPopularTVShows);
  });

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
      voteCount: 12
  );

  final tTVShowsList = <TvSeries>[tTVShow];

  group('TV Bloc, Popular TV Shows:', () {
    test('initialState should be Empty', () {
      expect(popularTVBloc.state, TvSeriesPopularEmptyState());
    });

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetPopularTVShows.execute())
            .thenAnswer((_) async => Right(tTVShowsList));
        return popularTVBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesPopularLoadingState(),
        TvSeriesPopularHasDataState(result: tTVShowsList)
      ],
      verify: (bloc) => verify(() => mockGetPopularTVShows.execute()),
    );

    blocTest<TvSeriesPopularBloc, TvSeriesPopularState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetPopularTVShows.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return popularTVBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        TvSeriesPopularLoadingState(),
        TvSeriesPopularErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockGetPopularTVShows.execute()),
    );
  });
}
