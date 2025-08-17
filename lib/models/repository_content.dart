import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'repository_content.g.dart';

@JsonSerializable()
class RepositoryContent {
  @JsonKey(name: '_links')
  final ContentLinks? links;
  final String? content;
  final String? encoding;
  @JsonKey(name: 'download_url')
  final String? downloadUrl;
  @JsonKey(name: 'git_url')
  final String? gitUrl;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final String name;
  final String path;
  final String sha;
  final int? size;
  final String type;
  final String url;

  RepositoryContent({
    this.links,
    this.content,
    this.encoding,
    this.downloadUrl,
    this.gitUrl,
    this.htmlUrl,
    required this.name,
    required this.path,
    required this.sha,
    this.size,
    required this.type,
    required this.url,
  });

  factory RepositoryContent.fromJson(Map<String, dynamic> json) =>
      _$RepositoryContentFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryContentToJson(this);

  bool get isFile => type == 'file';
  bool get isDirectory => type == 'dir';
  bool get isSymlink => type == 'symlink';
  bool get isSubmodule => type == 'submodule';

  String get sizeFormatted {
    if (size == null) return 'N/A';
    if (size! < 1024) return '$size B';
    if (size! < 1024 * 1024) return '${(size! / 1024).toStringAsFixed(2)} KB';
    if (size! < 1024 * 1024 * 1024) return '${(size! / (1024 * 1024)).toStringAsFixed(2)} MB';
    return '${(size! / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  String? get decodedContent {
    if (content != null) {
      try {
        return utf8.decode(base64.decode(content!.replaceAll('\n', '')));
      } catch (e) {
        return null;
      }
    }
    return content;
  }
}

@JsonSerializable()
class ContentLinks {
  final String? git;
  final String? html;
  final String? self;

  ContentLinks({
    this.git,
    this.html,
    this.self,
  });

  factory ContentLinks.fromJson(Map<String, dynamic> json) =>
      _$ContentLinksFromJson(json);

  Map<String, dynamic> toJson() => _$ContentLinksToJson(this);
}