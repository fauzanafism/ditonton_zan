import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:ditonton/presentation/widgets/movie_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(FetchWatchlistMovie());
      context.read<TvSeriesWatchlistBloc>().add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(FetchWatchlistMovie());
    context.read<TvSeriesWatchlistBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSubHeading(
                  title: 'Movies',
                  onTap: () => Navigator.pushNamed(
                      context, WatchlistMoviesPage.ROUTE_NAME),
                ),
                BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                  builder: (context, state) {
                    if (state is MovieWatchlistLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieWatchlistHasDataState) {
                      return MovieList(state.result);
                    } else if (state is MovieWatchlistErrorState) {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    } else if (state is MovieWatchlistEmptyState) {
                      return Center(
                        child: Text('No data'),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
                _buildSubHeading(
                  title: 'TV Series',
                  onTap: () => Navigator.pushNamed(
                      context, WatchlistTvSeriesPage.ROUTE_NAME),
                ),
                BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
                  builder: (context, state) {
                    if (state is TvSeriesWatchlistLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvSeriesWatchlistHasDataState) {
                      return TvSeriesList(state.result);
                    } else if (state is TvSeriesWatchlistErrorState) {
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    } else if (state is TvSeriesWatchlistEmptyState) {
                      return Center(
                        child: Text('No data'),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
