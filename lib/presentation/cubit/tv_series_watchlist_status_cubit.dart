import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusCubit extends Cubit<TvSeriesWatchlistStatusState> {
  TvSeriesWatchlistStatusCubit() : super(TvSeriesWatchlistStatusInitial());
}
