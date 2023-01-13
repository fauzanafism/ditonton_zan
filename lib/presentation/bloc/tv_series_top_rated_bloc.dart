import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  TvSeriesTopRatedBloc() : super(TvSeriesTopRatedInitial()) {
    on<TvSeriesTopRatedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
