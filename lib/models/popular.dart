
import 'package:bitbox_moviedb/models/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

part 'popular.g.dart';

@JsonSerializable()
class Popular extends ChangeNotifier{

  int page;

  @JsonKey(name: 'total_results')
  int totalResults;

  @JsonKey(name: 'total_pages')
  int totalPages;

  List<Result> results;

  Popular({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results
  });

  factory Popular.fromJson(Map<String, dynamic> json) => _$PopularFromJson(json);

  Map<String, dynamic> toJson() => _$PopularToJson(this);


}