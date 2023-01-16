import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTVSeries;

  TvSeriesTopRatedBloc({required this.getTopRatedTVSeries})
      : super(TvSeriesTopRatedEmptyState()) {
    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(TvSeriesTopRatedLoadingState());

      final result = await getTopRatedTVSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesTopRatedErrorState(message: failure.message)),
        (data) => emit(TvSeriesTopRatedHasDataState(result: data)),
      );
    });
  }
}
