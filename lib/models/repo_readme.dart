import 'package:json_annotation/json_annotation.dart';

part 'repo_readme.g.dart';

@JsonSerializable()
class RepositoryReadme {
  @JsonKey(name: '_links')
  final ContentLinks links;
  final String content;
  @JsonKey(name: 'download_url')
  final String downloadUrl;
  final String encoding;
  @JsonKey(name: 'git_url')
  final String gitUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String name;
  final String path;
  final String sha;
  final int size;
  @JsonKey(name: 'submodule_git_url')
  final String? submoduleGitUrl;
  final String? target;
  final String type;
  final String url;

  RepositoryReadme({
    required this.links,
    required this.content,
    required this.downloadUrl,
    required this.encoding,
    required this.gitUrl,
    required this.htmlUrl,
    required this.name,
    required this.path,
    required this.sha,
    required this.size,
    this.submoduleGitUrl,
    this.target,
    required this.type,
    required this.url,
  });

  factory RepositoryReadme.fromJson(Map<String, dynamic> json) => _$RepositoryReadmeFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryReadmeToJson(this);
}

@JsonSerializable()
class ContentLinks {
  final String git;
  final String html;
  final String self;

  ContentLinks({
    required this.git,
    required this.html,
    required this.self,
  });

  factory ContentLinks.fromJson(Map<String, dynamic> json) => _$ContentLinksFromJson(json);
  Map<String, dynamic> toJson() => _$ContentLinksToJson(this);
}