import 'package:ditonton/data/models/episode_model.dart';
import 'package:equatable/equatable.dart';

class EpisodeResponse extends Equatable {
  const EpisodeResponse({
    required this.episodes,
  });

  final List<EpisodeModel> episodes;

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
        episodes: List<EpisodeModel>.from(
          json["episodes"].map((x) => EpisodeModel.fromJson(x)),
        ),
      );

  @override
  List<Object?> get props => [episodes];
}
