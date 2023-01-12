import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviePopularBloc({required this.getPopularMovies})
      : super(MoviePopularEmptyState()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviePopularLoadingState());
      final result = await getPopularMovies.execute();

      result.fold(
          (failure) => emit(MoviePopularErrorState(message: failure.message)),
          (data) => emit(MoviePopularHasDataState(result: data)));
    });
  }
}
