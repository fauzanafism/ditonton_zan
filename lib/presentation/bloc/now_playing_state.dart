part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingEmptyState extends NowPlayingState {}

class NowPlayingLoadingState extends NowPlayingState {}

class NowPlayingErrorState extends NowPlayingState {
  final String message;

  NowPlayingErrorState({required this.message});
}

class NowPlayingHasDataState extends NowPlayingState {
  final List<Movie> result;

  NowPlayingHasDataState({required this.result});
}
