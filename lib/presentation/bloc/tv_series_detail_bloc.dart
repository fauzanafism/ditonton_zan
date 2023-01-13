import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  TvSeriesDetailBloc() : super(TvSeriesDetailInitial()) {
    on<TvSeriesDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
