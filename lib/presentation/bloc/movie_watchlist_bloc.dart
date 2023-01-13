import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc({required this.getWatchlistMovies})
      : super(MovieWatchlistEmptyState()) {
    on<MovieWatchlistEvent>((event, emit) async {
      emit(MovieWatchlistLoadingState());
      final result = await getWatchlistMovies.execute();

      result.fold(
          (failure) => emit(MovieWatchlistErrorState(message: failure.message)),
          (data) => emit(MovieWatchlistHasDataState(result: data)));
    });
  }
}
