// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      totalCount: (json['total_count'] as num).toInt(),
      incompleteResults: json['incomplete_results'] as bool,
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
    };

SearchReposResponse _$SearchReposResponseFromJson(Map<String, dynamic> json) =>
    SearchReposResponse(
      totalCount: (json['total_count'] as num).toInt(),
      incompleteResults: json['incomplete_results'] as bool,
      repositories: (json['items'] as List<dynamic>)
          .map((e) => Repository.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchReposResponseToJson(
  SearchReposResponse instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'incomplete_results': instance.incompleteResults,
  'items': instance.repositories,
};

SearchUsersResponse _$SearchUsersResponseFromJson(Map<String, dynamic> json) =>
    SearchUsersResponse(
      totalCount: (json['total_count'] as num).toInt(),
      incompleteResults: json['incomplete_results'] as bool,
      users: (json['items'] as List<dynamic>)
          .map((e) => SimpleGitHubUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchUsersResponseToJson(
  SearchUsersResponse instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'incomplete_results': instance.incompleteResults,
  'items': instance.users,
};

SearchCodeResponse _$SearchCodeResponseFromJson(Map<String, dynamic> json) =>
    SearchCodeResponse(
      totalCount: (json['total_count'] as num).toInt(),
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => CodeSearchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchCodeResponseToJson(SearchCodeResponse instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };

CodeSearchItem _$CodeSearchItemFromJson(Map<String, dynamic> json) =>
    CodeSearchItem(
      name: json['name'] as String?,
      path: json['path'] as String?,
      sha: json['sha'] as String?,
      url: json['url'] as String?,
      gitUrl: json['git_url'] as String?,
      htmlUrl: json['html_url'] as String?,
      repository: json['repository'] == null
          ? null
          : Repository.fromJson(json['repository'] as Map<String, dynamic>),
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CodeSearchItemToJson(CodeSearchItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'sha': instance.sha,
      'url': instance.url,
      'git_url': instance.gitUrl,
      'html_url': instance.htmlUrl,
      'repository': instance.repository,
      'score': instance.score,
    };

SearchCommitsResponse _$SearchCommitsResponseFromJson(
  Map<String, dynamic> json,
) => SearchCommitsResponse(
  totalCount: (json['total_count'] as num).toInt(),
  incompleteResults: json['incomplete_results'] as bool,
  commits: (json['items'] as List<dynamic>)
      .map((e) => CommitSearchItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SearchCommitsResponseToJson(
  SearchCommitsResponse instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'incomplete_results': instance.incompleteResults,
  'items': instance.commits,
};

CommitSearchItem _$CommitSearchItemFromJson(Map<String, dynamic> json) =>
    CommitSearchItem(
      url: json['url'] as String?,
      sha: json['sha'] as String?,
      htmlUrl: json['html_url'] as String?,
      commentsUrl: json['comments_url'] as String?,
      commit: json['commit'] == null
          ? null
          : CommitDetails.fromJson(json['commit'] as Map<String, dynamic>),
      author: json['author'] == null
          ? null
          : Owner.fromJson(json['author'] as Map<String, dynamic>),
      committer: json['committer'] == null
          ? null
          : Owner.fromJson(json['committer'] as Map<String, dynamic>),
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => CommitParent.fromJson(e as Map<String, dynamic>))
          .toList(),
      repository: json['repository'] == null
          ? null
          : Repository.fromJson(json['repository'] as Map<String, dynamic>),
      score: (json['score'] as num?)?.toDouble(),
      nodeId: json['node_id'] as String?,
    );

Map<String, dynamic> _$CommitSearchItemToJson(CommitSearchItem instance) =>
    <String, dynamic>{
      'url': instance.url,
      'sha': instance.sha,
      'html_url': instance.htmlUrl,
      'comments_url': instance.commentsUrl,
      'commit': instance.commit,
      'author': instance.author,
      'committer': instance.committer,
      'parents': instance.parents,
      'repository': instance.repository,
      'score': instance.score,
      'node_id': instance.nodeId,
    };
