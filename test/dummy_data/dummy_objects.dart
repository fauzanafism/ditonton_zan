import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

//
final testTvSeries = TvSeries(
    backdropPath: '/tE6dWq9neq2IPSc6kJQdxyMrl7w.jpg',
    firstAirDate: '2022-08-15',
    genreIds: [10759, 10765, 18],
    id: 121750,
    name: 'Darna',
    originalName: 'Darna',
    overview:
        "When fragments of a green crystal scatter in the city and turn people into destructive monsters, Narda embraces her destiny as Darna—the mighty protector of the powerful stone from Planet Marte.",
    popularity: 909.96,
    posterPath: "/CFOce6pbb3FRNaBaVdvNsCv5kR.jpg",
    voteAverage: 4.8,
    voteCount: 12);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
    backdropPath: "/hoVuI69nygLQBJ4FqgRKnukDeKt.jpg",
    firstAirDate: "2022-12-25",
    genres: [
      Genre(id: 10759, name: "Action & Adventure"),
      Genre(id: 10765, name: "Sci-Fi & Fantasy")
    ],
    id: 106541,
    name: "The Witcher: Blood Origin",
    originalName: "The Witcher: Blood Origin",
    overview:
        "More than a thousand years before the world of The Witcher, seven outcasts in the elven world unite in a blood quest against an unstoppable power.",
    posterPath: "/vpfJK9F0UJNcAIIeC42oJyKMnZQ.jpg",
    seasons: [
      Season(
          airDate: "2022-12-25",
          episodeCount: 4,
          id: 157411,
          name: "Limited Series",
          overview: "",
          posterPath: "/49WEpzSvhz2KoPNblU3FT2gVbzP.jpg",
          seasonNumber: 1)
    ],
    tagline: "Every story has a beginning.",
    voteAverage: 6.465,
    voteCount: 185);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'title',
};
