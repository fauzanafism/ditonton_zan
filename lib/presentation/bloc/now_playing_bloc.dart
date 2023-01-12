import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingBloc({required this.getNowPlayingMovies})
      : super(NowPlayingEmptyState()) {
    on<FetchNowPlayingMovie>((event, emit) async {
      emit(NowPlayingLoadingState());
      final result = await getNowPlayingMovies.execute();

      result.fold(
          (failure) => emit(NowPlayingErrorState(message: failure.message)),
          (data) => emit(NowPlayingHasDataState(result: data)));
    });
  }
}
