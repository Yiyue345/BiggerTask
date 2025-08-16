// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeItem _$TreeItemFromJson(Map<String, dynamic> json) => TreeItem(
  path: json['path'] as String,
  mode: json['mode'] as String,
  type: json['type'] as String,
  sha: json['sha'] as String,
  url: json['url'] as String?,
  size: (json['size'] as num?)?.toInt(),
);

Map<String, dynamic> _$TreeItemToJson(TreeItem instance) => <String, dynamic>{
  'path': instance.path,
  'mode': instance.mode,
  'type': instance.type,
  'sha': instance.sha,
  'url': instance.url,
  'size': instance.size,
};
