import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/presentation/bloc/airing_today_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAiringToday extends Mock implements GetAiringTodayTvSeries {}

void main() {
  late MockAiringToday mockAiringToday;
  late AiringTodayBloc airingTodayBloc;

  setUp(() {
    mockAiringToday = MockAiringToday();
    airingTodayBloc = AiringTodayBloc(getAiringTodayTvSeries: mockAiringToday);
  });

  final tTvSeries = TvSeries(
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

  final tTVShowsList = <TvSeries>[tTvSeries];

  group('TV Bloc, On The Air TV Shows:', () {
    test('initialState should be Empty', () {
      expect(airingTodayBloc.state, AiringTodayEmptyState());
    });

    blocTest<AiringTodayBloc, AiringTodayState>(
      'should emit[Loading, HasData] when data is gotten successfully',
      build: () {
        when(() => mockAiringToday.execute())
            .thenAnswer((_) async => Right(tTVShowsList));
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(FetchAiringToday()),
      expect: () => [
        AiringTodayLoadingState(),
        AiringTodayHasDataState(result: tTVShowsList)
      ],
      verify: (bloc) => verify(() => mockAiringToday.execute()),
    );

    blocTest<AiringTodayBloc, AiringTodayState>(
      'should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(() => mockAiringToday.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(FetchAiringToday()),
      expect: () => [
        AiringTodayLoadingState(),
        AiringTodayErrorState(message: 'Server Failure'),
      ],
      verify: (bloc) => verify(() => mockAiringToday.execute()),
    );
  });
}
