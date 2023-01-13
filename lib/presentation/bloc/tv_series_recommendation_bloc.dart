import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  TvSeriesRecommendationBloc() : super(TvSeriesRecommendationInitial()) {
    on<TvSeriesRecommendationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
