import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieTopRatedBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class MovieTopRatedEventFake extends Fake implements MovieTopRatedEvent {}

class MovieTopRatedStateFake extends Fake implements MovieTopRatedState {}

void main() {
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(MovieTopRatedEventFake());
    registerFallbackValue(MovieTopRatedStateFake());
  });

  setUp(() {
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>.value(
      value: mockMovieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Page, Popular Movie Page:', () {
    testWidgets('page should nothing when empty', (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedEmptyState());
      await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      expect(progressBarFinder, findsNothing);
    });

    testWidgets('page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedLoadingState());
      await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedHasDataState(result: testMovieList));

      await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => mockMovieTopRatedBloc.state)
          .thenReturn(MovieTopRatedErrorState(message: 'Error'));

      await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

      final textFinder = find.byKey(const Key('error_message'));
      expect(textFinder, findsOneWidget);
    });
  });
}
