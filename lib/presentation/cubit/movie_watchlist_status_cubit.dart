import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movie_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusCubit extends Cubit<MovieWatchlistStatusState> {
  final GetWatchListMovieStatus getWatchListMovieStatus;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;

  static const successMessage = 'Added to Watchlist';
  static const removeMessage = 'Removed from Watchlist'; 

  MovieWatchlistStatusCubit(
      {required this.getWatchListMovieStatus,
      required this.saveWatchlistMovie,
      required this.removeWatchlistMovie})
      : super(MovieWatchlistStatusState(isAddedWatchlist: false, message: ''));

  void loadWatchlistStatus(int id) async {
    final result = await getWatchListMovieStatus.execute(id);
    emit(MovieWatchlistStatusState(isAddedWatchlist: result, message: ''));
  }

  Future<void> addWatchlistMovie(MovieDetail movie) async {
    final result = await saveWatchlistMovie.execute(movie);
    final resultBool = await getWatchListMovieStatus.execute(movie.id);

    result.fold(
      (failure) async {
        emit(MovieWatchlistStatusState(
          message: failure.message,
          isAddedWatchlist: resultBool,
        ));
      },
      (successMessage) async {
        emit(MovieWatchlistStatusState(
          message: successMessage,
          isAddedWatchlist: resultBool,
        ));
      },
    );
  }

  Future<void> removeFromWatchlistMovie(MovieDetail movie) async {
    final result = await removeWatchlistMovie.execute(movie);
    final resultBool = await getWatchListMovieStatus.execute(movie.id);

    result.fold(
      (failure) async {
        emit(MovieWatchlistStatusState(
          message: failure.message,
          isAddedWatchlist: resultBool,
        ));
      },
      (successMessage) async {
        emit(MovieWatchlistStatusState(
          message: successMessage,
          isAddedWatchlist: resultBool,
        ));
      },
    );
  }
}
