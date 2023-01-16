part of 'tv_series_popular_bloc.dart';

@immutable
abstract class TvSeriesPopularEvent extends Equatable {
  const TvSeriesPopularEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularTvSeries extends TvSeriesPopularEvent {}
