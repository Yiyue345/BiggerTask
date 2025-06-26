// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_readme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepositoryReadme _$RepositoryReadmeFromJson(Map<String, dynamic> json) =>
    RepositoryReadme(
      links: ContentLinks.fromJson(json['_links'] as Map<String, dynamic>),
      content: json['content'] as String,
      downloadUrl: json['download_url'] as String,
      encoding: json['encoding'] as String,
      gitUrl: json['git_url'] as String,
      htmlUrl: json['html_url'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      sha: json['sha'] as String,
      size: (json['size'] as num).toInt(),
      submoduleGitUrl: json['submodule_git_url'] as String?,
      target: json['target'] as String?,
      type: json['type'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$RepositoryReadmeToJson(RepositoryReadme instance) =>
    <String, dynamic>{
      '_links': instance.links,
      'content': instance.content,
      'download_url': instance.downloadUrl,
      'encoding': instance.encoding,
      'git_url': instance.gitUrl,
      'html_url': instance.htmlUrl,
      'name': instance.name,
      'path': instance.path,
      'sha': instance.sha,
      'size': instance.size,
      'submodule_git_url': instance.submoduleGitUrl,
      'target': instance.target,
      'type': instance.type,
      'url': instance.url,
    };

ContentLinks _$ContentLinksFromJson(Map<String, dynamic> json) => ContentLinks(
  git: json['git'] as String,
  html: json['html'] as String,
  self: json['self'] as String,
);

Map<String, dynamic> _$ContentLinksToJson(ContentLinks instance) =>
    <String, dynamic>{
      'git': instance.git,
      'html': instance.html,
      'self': instance.self,
    };
