import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable()
class SearchResponse {
  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;

  SearchResponse({
    required this.totalCount,
    required this.incompleteResults,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class SearchReposResponse extends SearchResponse {
  @JsonKey(name: 'items')
  final List<Repository> repositories;

  SearchReposResponse({
    required super.totalCount,
    required super.incompleteResults,
    required this.repositories,
  });

  factory SearchReposResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchReposResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReposResponseToJson(this);
}

@JsonSerializable()
class SearchUsersResponse extends SearchResponse {
  @JsonKey(name: 'items')
  final List<SimpleGitHubUser> users;

  SearchUsersResponse({
    required super.totalCount,
    required super.incompleteResults,
    required this.users,
  });

  factory SearchUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUsersResponseToJson(this);
}
