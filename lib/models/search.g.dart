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
      name: json['name'] as String,
      path: json['path'] as String,
      sha: json['sha'] as String,
      url: json['url'] as String,
      gitUrl: json['git_url'] as String,
      htmlUrl: json['html_url'] as String,
      repository: Repository.fromJson(
        json['repository'] as Map<String, dynamic>,
      ),
      score: (json['score'] as num).toDouble(),
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
