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
      repositories:
          (json['items'] as List<dynamic>)
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
      users:
          (json['items'] as List<dynamic>)
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
