import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  TvSeriesSearchBloc() : super(TvSeriesSearchInitial()) {
    on<TvSeriesSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
