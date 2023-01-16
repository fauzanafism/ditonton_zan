import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTVShows;

  TvSeriesWatchlistBloc({required this.getWatchlistTVShows})
      : super(TvSeriesWatchlistEmptyState()) {
    on<TvSeriesWatchlistEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoadingState());

      final result = await getWatchlistTVShows.execute();

      result.fold(
        (failure) => emit(TvSeriesWatchlistErrorState(message: failure.message)),
        (data) => emit(TvSeriesWatchlistHasDataState(result: data)),
      );
    });
  }
}
