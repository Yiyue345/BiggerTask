import 'package:json_annotation/json_annotation.dart';
import 'repository.dart';

part 'commit.g.dart';

@JsonSerializable()
class Commit {
  final Owner? author;
  @JsonKey(name: 'comments_url')
  final String? commentsUrl;
  final CommitDetails? commit;
  final Owner? committer;
  final List<CommitFile>? files;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  final List<CommitParent>? parents;
  final String? sha;
  final CommitStats? stats;
  final String? url;

  Commit({
    this.author,
    this.commentsUrl,
    this.commit,
    this.committer,
    this.files,
    this.htmlUrl,
    this.nodeId,
    this.parents,
    this.sha,
    this.stats,
    this.url,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);
  Map<String, dynamic> toJson() => _$CommitToJson(this);
}

@JsonSerializable()
class CommitDetails {
  final CommitAuthor? author;
  @JsonKey(name: 'comment_count')
  final int? commentCount;
  final CommitAuthor? committer;
  final String? message;
  final CommitTree? tree;
  final String? url;
  final CommitVerification? verification;

  CommitDetails({
    this.author,
    this.commentCount,
    this.committer,
    this.message,
    this.tree,
    this.url,
    this.verification,
  });

  factory CommitDetails.fromJson(Map<String, dynamic> json) => _$CommitDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CommitDetailsToJson(this);
}

@JsonSerializable()
class CommitAuthor {
  final String? date;
  final String? email;
  final String? name;

  CommitAuthor({
    this.date,
    this.email,
    this.name,
  });

  factory CommitAuthor.fromJson(Map<String, dynamic> json) => _$CommitAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$CommitAuthorToJson(this);
}

@JsonSerializable()
class CommitTree {
  final String? sha;
  final String? url;

  CommitTree({
    this.sha,
    this.url,
  });

  factory CommitTree.fromJson(Map<String, dynamic> json) => _$CommitTreeFromJson(json);
  Map<String, dynamic> toJson() => _$CommitTreeToJson(this);
}

@JsonSerializable()
class CommitVerification {
  final String? payload;
  final String? reason;
  final String? signature;
  final bool? verified;

  CommitVerification({
    this.payload,
    this.reason,
    this.signature,
    this.verified,
  });

  factory CommitVerification.fromJson(Map<String, dynamic> json) => _$CommitVerificationFromJson(json);
  Map<String, dynamic> toJson() => _$CommitVerificationToJson(this);
}

@JsonSerializable()
class CommitFile {
  final int? additions;
  @JsonKey(name: 'blob_url')
  final String? blobUrl;
  final int? changes;
  @JsonKey(name: 'contents_url')
  final String? contentsUrl;
  final int? deletions;
  final String? filename;
  final String? patch;
  @JsonKey(name: 'previous_filename')
  final String? previousFilename;
  @JsonKey(name: 'raw_url')
  final String? rawUrl;
  final String? sha;
  final String? status;

  CommitFile({
    this.additions,
    this.blobUrl,
    this.changes,
    this.contentsUrl,
    this.deletions,
    this.filename,
    this.patch,
    this.previousFilename,
    this.rawUrl,
    this.sha,
    this.status,
  });

  factory CommitFile.fromJson(Map<String, dynamic> json) => _$CommitFileFromJson(json);
  Map<String, dynamic> toJson() => _$CommitFileToJson(this);
}

@JsonSerializable()
class CommitParent {
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final String? sha;
  final String? url;

  CommitParent({
    this.htmlUrl,
    this.sha,
    this.url,
  });

  factory CommitParent.fromJson(Map<String, dynamic> json) => _$CommitParentFromJson(json);
  Map<String, dynamic> toJson() => _$CommitParentToJson(this);
}

@JsonSerializable()
class CommitStats {
  final int? additions;
  final int? deletions;
  final int? total;

  CommitStats({
    this.additions,
    this.deletions,
    this.total,
  });

  factory CommitStats.fromJson(Map<String, dynamic> json) => _$CommitStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CommitStatsToJson(this);
}
