import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularBloc({required this.getPopularTvSeries})
      : super(TvSeriesPopularEmptyState()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(TvSeriesPopularLoadingState());

      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) => emit(TvSeriesPopularErrorState(message: failure.message)),
        (data) => emit(TvSeriesPopularHasDataState(result: data)),
      );
    });
  }
}