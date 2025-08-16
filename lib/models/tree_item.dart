import 'package:json_annotation/json_annotation.dart';

part 'tree_item.g.dart';

@JsonSerializable()
class TreeItem {
  final String path;
  final String mode;
  final String type; // "blob" for files, "tree" for directories
  final String sha;
  final String? url;
  final int? size;

  TreeItem({
    required this.path,
    required this.mode,
    required this.type,
    required this.sha,
    this.url,
    this.size,
  });

  factory TreeItem.fromJson(Map<String, dynamic> json) {
    return _$TreeItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TreeItemToJson(this);

  bool get isFile => type == 'blob';
  bool get isDirectory => type == 'tree';
}