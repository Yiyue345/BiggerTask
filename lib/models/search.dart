import 'package:biggertask/models/github_user.dart';
import 'package:biggertask/models/repository.dart';
import 'package:biggertask/models/commit.dart';
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

@JsonSerializable()
class SearchCodeResponse extends SearchResponse {
  @JsonKey(name: 'items')
  final List<CodeSearchItem> items;

  SearchCodeResponse({
    required super.totalCount,
    required super.incompleteResults,
    required this.items,
  });

  factory SearchCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCodeResponseToJson(this);
}

@JsonSerializable()
class CodeSearchItem {
  final String? name;
  final String? path;
  final String? sha;
  final String? url;
  @JsonKey(name: 'git_url')
  final String? gitUrl;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  @JsonKey(name: 'repository')
  final Repository? repository;
  final double? score;

  CodeSearchItem({
    this.name,
    this.path,
    this.sha,
    this.url,
    this.gitUrl,
    this.htmlUrl,
    this.repository,
    this.score,
  });

  factory CodeSearchItem.fromJson(Map<String, dynamic> json) =>
      _$CodeSearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$CodeSearchItemToJson(this);
}

@JsonSerializable()
class SearchCommitsResponse extends SearchResponse {
  @JsonKey(name: 'items')
  final List<CommitSearchItem> commits;

  SearchCommitsResponse({
    required super.totalCount,
    required super.incompleteResults,
    required this.commits,
  });

  factory SearchCommitsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCommitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCommitsResponseToJson(this);
}

@JsonSerializable()
class CommitSearchItem {
  final String? url;
  final String? sha;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  @JsonKey(name: 'comments_url')
  final String? commentsUrl;
  final CommitDetails? commit;
  final Owner? author;
  final Owner? committer;
  final List<CommitParent>? parents;
  final Repository? repository;
  final double? score;
  @JsonKey(name: 'node_id')
  final String? nodeId;

  CommitSearchItem({
    this.url,
    this.sha,
    this.htmlUrl,
    this.commentsUrl,
    this.commit,
    this.author,
    this.committer,
    this.parents,
    this.repository,
    this.score,
    this.nodeId,
  });

  factory CommitSearchItem.fromJson(Map<String, dynamic> json) =>
      _$CommitSearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommitSearchItemToJson(this);
}
