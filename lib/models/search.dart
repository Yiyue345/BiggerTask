import 'package:biggertask/models/repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable()
class SearchReposResponse {
  @JsonKey(name: 'items')
  final List<Repository> repositories;

  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;

  SearchReposResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.repositories,
  });

  factory SearchReposResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchReposResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReposResponseToJson(this);
}