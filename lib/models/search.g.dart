// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
  'items': instance.repositories,
  'total_count': instance.totalCount,
  'incomplete_results': instance.incompleteResults,
};
