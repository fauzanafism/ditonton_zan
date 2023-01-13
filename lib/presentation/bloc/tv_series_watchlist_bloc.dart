import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  TvSeriesWatchlistBloc() : super(TvSeriesWatchlistInitial()) {
    on<TvSeriesWatchlistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
