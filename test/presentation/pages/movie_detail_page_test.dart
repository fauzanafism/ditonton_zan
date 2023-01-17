import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/cubit/movie_watchlist_status_cubit.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class DetailMovieEventFake extends Fake implements MovieDetailEvent {}

class DetailMovieStateFake extends Fake implements MovieDetailState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MovieRecommendationEventFake extends Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake
    implements MovieRecommendationState {}

class MockMovieWatchlistStatusCubit extends MockCubit<MovieWatchlistStatusState>
    implements MovieWatchlistStatusCubit {}

class MovieWatchlistStatusStateFake extends Fake
    implements MovieWatchlistStatusState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockMovieWatchlistStatusCubit mockMovieWatchlistStatusCubit;

  setUpAll(() {
    registerFallbackValue(DetailMovieEventFake());
    registerFallbackValue(DetailMovieStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockMovieWatchlistStatusCubit = MockMovieWatchlistStatusCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<MovieRecommendationBloc>.value(
            value: mockMovieRecommendationBloc),
        BlocProvider<MovieWatchlistStatusCubit>.value(
          value: mockMovieWatchlistStatusCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Page, Detail Movie Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieDetailEmptyState());
      when(() => mockMovieWatchlistStatusCubit.state).thenReturn(
          const MovieWatchlistStatusState(
              isAddedWatchlist: false, message: ''));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationEmptyState());

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailLoadingState());
      when(() => mockMovieWatchlistStatusCubit.state).thenReturn(
          const MovieWatchlistStatusState(
              isAddedWatchlist: false, message: ''));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationLoadingState());

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display Detail when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasDataState(result: testMovieDetail));
      when(() => mockMovieWatchlistStatusCubit.state).thenReturn(
          const MovieWatchlistStatusState(
              isAddedWatchlist: false, message: ''));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationHasDataState(result: testMovieList));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(
        id: testMovieDetail.id,
      )));

      final buttonFinder = find.byType(ElevatedButton);
      final listViewFinder = find.byType(ListView);

      expect(buttonFinder, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailErrorState('Error'));
      when(() => mockMovieWatchlistStatusCubit.state).thenReturn(
          const MovieWatchlistStatusState(
              isAddedWatchlist: false, message: ''));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationErrorState(message: 'Error'));

      await tester.pumpWidget(makeTestableWidget(MovieDetailPage(
        id: testMovieDetail.id,
      )));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });

  group('Movie Page, Detail Movie Widgets:', () {
    testWidgets(
        'watchlist button should display add icon when movie not added to watchlist',
        (tester) async {
      final watchlistButton = find.byType(ElevatedButton);
      final iconButton = find.byIcon(Icons.add);

      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasDataState(result: testMovieDetail));
      when(() => mockMovieWatchlistStatusCubit.state).thenReturn(
          const MovieWatchlistStatusState(
              isAddedWatchlist: false, message: ''));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationHasDataState(result: testMovieList));

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(watchlistButton, findsOneWidget);
      expect(iconButton, findsOneWidget);
    });

    testWidgets(
        'watchlist button should dispay check icon when movie is added to wathclist',
        (tester) async {
      final watchlistButton = find.byType(ElevatedButton);
      final iconButton = find.byIcon(Icons.check);

      when(() => mockMovieDetailBloc.state)
          .thenReturn(MovieDetailHasDataState(result: testMovieDetail));
      when(() => mockMovieWatchlistStatusCubit.state).thenReturn(
          const MovieWatchlistStatusState(isAddedWatchlist: true, message: ''));
      when(() => mockMovieRecommendationBloc.state)
          .thenReturn(MovieRecommendationHasDataState(result: testMovieList));

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(watchlistButton, findsOneWidget);
      expect(iconButton, findsOneWidget);
    });
  });
}
