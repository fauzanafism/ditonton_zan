import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<RecommendationTvEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendation getTvSeriesRecommendation;

  TvSeriesRecommendationBloc({required this.getTvSeriesRecommendation})
      : super(TvSeriesRecommendationEmptyState()) {
    on<FetchRecommendationTvSeries>((event, emit) async {
      emit(TvSeriesRecommendationLoadingState());

      final result = await getTvSeriesRecommendation.execute(event.id);

      result.fold(
        (failure) =>
            emit(TvSeriesRecommendationErrorState(message: failure.message)),
        (data) => emit(TvSeriesRecommendationHasDataState(result: data)),
      );
    });
  }
}
