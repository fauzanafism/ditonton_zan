import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailBloc({required this.getTvSeriesDetail})
      : super(TvSeriesDetailEmptyState()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(TvSeriesDetailLoadingState());

      final result = await getTvSeriesDetail.execute(event.id);

      result.fold(
          (failure) => emit(TvSeriesDetailErrorState(message: failure.message)),
          (data) => emit(TvSeriesDetailHasDataState(result: data)));
    });
  }
}
