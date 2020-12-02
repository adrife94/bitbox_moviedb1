import 'package:json_annotation/json_annotation.dart';

import 'package:bitbox_moviedb/models/movie.dart';

part 'popular.g.dart';

@JsonSerializable()
class Popular {
  int page;

  @JsonKey(name: 'total_results')
  int totalResults;

  @JsonKey(name: 'total_pages')
  int totalPages;

  List<Movie> results = [];

  Popular({this.page, this.totalResults, this.totalPages, this.results});

  factory Popular.fromJson(Map<String, dynamic> json) =>
      _$PopularFromJson(json);

  Map<String, dynamic> toJson() => _$PopularToJson(this);
}
