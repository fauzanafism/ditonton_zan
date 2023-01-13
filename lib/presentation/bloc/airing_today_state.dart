part of 'airing_today_bloc.dart';

abstract class AiringTodayState extends Equatable {
  const AiringTodayState();

  @override
  List<Object> get props => [];
}

class AiringTodayEmptyState extends AiringTodayState {}

class AiringTodayLoadingState extends AiringTodayState {}

class AiringTodayErrorState extends AiringTodayState {
  final String message;

  AiringTodayErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class AiringTodayHasDataState extends AiringTodayState {
  final List<TvSeries> result;

  AiringTodayHasDataState({required this.result});

  @override
  List<Object> get props => [result];
}
