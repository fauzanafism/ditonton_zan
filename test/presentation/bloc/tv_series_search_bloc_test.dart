import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchTVSeries extends Mock implements SearchTvSeries {}

void main() {
  late MockSearchTVSeries mockSearchTVShows;
  late TvSeriesSearchBloc searchTVBloc;

  setUp(() {
    mockSearchTVShows = MockSearchTVSeries();
    searchTVBloc = TvSeriesSearchBloc(searchTvSeries: mockSearchTVShows);
  });

  final tTVShowModel = TvSeries(
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
  final tTVShowsList = [tTVShowModel];
  const tQuery = 'Titan';

  group('TV Bloc, Search TV Shows:', () {
    test('initialState should be Empty', () {
      expect(searchTVBloc.state, TvSeriesSearchEmptyState());
    });

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockSearchTVShows.execute(tQuery))
            .thenAnswer((_) async => Right(tTVShowsList));
        return searchTVBloc;
      },
      act: (bloc) => bloc.add(const OnQueryTvChange(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesSearchLoadingState(),
        TvSeriesSearchHasDataState(result: tTVShowsList),
      ],
      verify: (bloc) => verify(() => mockSearchTVShows.execute(tQuery)),
    );

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockSearchTVShows.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTVBloc;
      },
      act: (bloc) => bloc.add(const OnQueryTvChange(query: tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvSeriesSearchLoadingState(),
        const TvSeriesSearchErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockSearchTVShows.execute(tQuery)),
    );
  });
}
