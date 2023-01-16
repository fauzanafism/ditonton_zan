import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';


class MockGetWatchlistTVSeries extends Mock implements GetWatchlistTvSeries {}

void main() {
  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  late TvSeriesWatchlistBloc watchlistTVBloc;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    watchlistTVBloc =
        TvSeriesWatchlistBloc(getWatchlistTVShows: mockGetWatchlistTVSeries);
  });

  group('TV Bloc, Watchlist TV Shows:', () {
    test('initialState should be Empty', () {
      expect(watchlistTVBloc.state, TvSeriesWatchlistEmptyState());
    });

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockGetWatchlistTVSeries.execute())
            .thenAnswer((_) async => Right([testWatchlistTvSeries]));
        return watchlistTVBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        TvSeriesWatchlistLoadingState(),
        TvSeriesWatchlistHasDataState(result: [testWatchlistTvSeries])
      ],
      verify: (bloc) => verify(() => mockGetWatchlistTVSeries.execute()),
    );

    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockGetWatchlistTVSeries.execute()).thenAnswer(
            (_) async => Left(DatabaseFailure("Can't get data")));
        return watchlistTVBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        TvSeriesWatchlistLoadingState(),
        const TvSeriesWatchlistErrorState(message: "Can't get data"),
      ],
      verify: (bloc) => verify(() => mockGetWatchlistTVSeries.execute()),
    );
  });
}
