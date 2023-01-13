import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  TvSeriesPopularBloc() : super(TvSeriesPopularInitial()) {
    on<TvSeriesPopularEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
