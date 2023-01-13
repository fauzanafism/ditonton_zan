import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  MovieTopRatedBloc({required this.getTopRatedMovies}) : super(MovieTopRatedEmptyState()) {
    on<FetchTopRatedMovie>((event, emit) async {
      emit(MovieTopRatedLoadingState());
      final result = await getTopRatedMovies.execute();

      result.fold((failure) => emit(MovieTopRatedErrorState(message: failure.message)), (data) => emit(MovieTopRatedHasDataState(result: data)));

    });
  }
}
