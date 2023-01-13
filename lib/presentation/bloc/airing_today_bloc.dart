import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_event.dart';
part 'airing_today_state.dart';

class AiringTodayBloc extends Bloc<AiringTodayEvent, AiringTodayState> {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  AiringTodayBloc({required this.getAiringTodayTvSeries}) : super(AiringTodayEmptyState()) {
    on<FetchAiringToday>((event, emit) async {
      emit(AiringTodayLoadingState());
      final result = await getAiringTodayTvSeries.execute();

      result.fold((failure) => emit(AiringTodayErrorState(message: failure.message)), (data) => emit(AiringTodayHasDataState(result: data)));
    });
  }
}
