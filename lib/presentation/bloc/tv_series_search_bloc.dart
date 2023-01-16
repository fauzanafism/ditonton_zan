import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc({required this.searchTvSeries}) : super(TvSeriesSearchEmptyState()) {
    on<OnQueryTvChange>((event, emit) async {
      emit(TvSeriesSearchLoadingState());

      final result = await searchTvSeries.execute(event.query);

      result.fold(
        (failed) => emit(TvSeriesSearchErrorState(message: failed.message)),
        (data) => emit(TvSeriesSearchHasDataState(result: data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}