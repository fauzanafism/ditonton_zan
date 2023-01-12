import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies})
      : super(MovieSearchEmptyState()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(MovieSearchLoadingState());
      final result = await searchMovies.execute(query);

      result.fold(
          (failure) => emit(MovieSearchErrorState(message: failure.message)),
          (data) => emit(MovieSearchHasDataState(result: data)));
    });
  }
}
