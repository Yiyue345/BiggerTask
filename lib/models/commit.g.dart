// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commit _$CommitFromJson(Map<String, dynamic> json) => Commit(
  author: json['author'] == null
      ? null
      : Owner.fromJson(json['author'] as Map<String, dynamic>),
  commentsUrl: json['comments_url'] as String?,
  commit: json['commit'] == null
      ? null
      : CommitDetails.fromJson(json['commit'] as Map<String, dynamic>),
  committer: json['committer'] == null
      ? null
      : Owner.fromJson(json['committer'] as Map<String, dynamic>),
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => CommitFile.fromJson(e as Map<String, dynamic>))
      .toList(),
  htmlUrl: json['html_url'] as String?,
  nodeId: json['node_id'] as String?,
  parents: (json['parents'] as List<dynamic>?)
      ?.map((e) => CommitParent.fromJson(e as Map<String, dynamic>))
      .toList(),
  sha: json['sha'] as String?,
  stats: json['stats'] == null
      ? null
      : CommitStats.fromJson(json['stats'] as Map<String, dynamic>),
  url: json['url'] as String?,
);

Map<String, dynamic> _$CommitToJson(Commit instance) => <String, dynamic>{
  'author': instance.author,
  'comments_url': instance.commentsUrl,
  'commit': instance.commit,
  'committer': instance.committer,
  'files': instance.files,
  'html_url': instance.htmlUrl,
  'node_id': instance.nodeId,
  'parents': instance.parents,
  'sha': instance.sha,
  'stats': instance.stats,
  'url': instance.url,
};

CommitDetails _$CommitDetailsFromJson(Map<String, dynamic> json) =>
    CommitDetails(
      author: json['author'] == null
          ? null
          : CommitAuthor.fromJson(json['author'] as Map<String, dynamic>),
      commentCount: (json['comment_count'] as num?)?.toInt(),
      committer: json['committer'] == null
          ? null
          : CommitAuthor.fromJson(json['committer'] as Map<String, dynamic>),
      message: json['message'] as String?,
      tree: json['tree'] == null
          ? null
          : CommitTree.fromJson(json['tree'] as Map<String, dynamic>),
      url: json['url'] as String?,
      verification: json['verification'] == null
          ? null
          : CommitVerification.fromJson(
              json['verification'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CommitDetailsToJson(CommitDetails instance) =>
    <String, dynamic>{
      'author': instance.author,
      'comment_count': instance.commentCount,
      'committer': instance.committer,
      'message': instance.message,
      'tree': instance.tree,
      'url': instance.url,
      'verification': instance.verification,
    };

CommitAuthor _$CommitAuthorFromJson(Map<String, dynamic> json) => CommitAuthor(
  date: json['date'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$CommitAuthorToJson(CommitAuthor instance) =>
    <String, dynamic>{
      'date': instance.date,
      'email': instance.email,
      'name': instance.name,
    };

CommitTree _$CommitTreeFromJson(Map<String, dynamic> json) =>
    CommitTree(sha: json['sha'] as String?, url: json['url'] as String?);

Map<String, dynamic> _$CommitTreeToJson(CommitTree instance) =>
    <String, dynamic>{'sha': instance.sha, 'url': instance.url};

CommitVerification _$CommitVerificationFromJson(Map<String, dynamic> json) =>
    CommitVerification(
      payload: json['payload'] as String?,
      reason: json['reason'] as String?,
      signature: json['signature'] as String?,
      verified: json['verified'] as bool?,
    );

Map<String, dynamic> _$CommitVerificationToJson(CommitVerification instance) =>
    <String, dynamic>{
      'payload': instance.payload,
      'reason': instance.reason,
      'signature': instance.signature,
      'verified': instance.verified,
    };

CommitFile _$CommitFileFromJson(Map<String, dynamic> json) => CommitFile(
  additions: (json['additions'] as num?)?.toInt(),
  blobUrl: json['blob_url'] as String?,
  changes: (json['changes'] as num?)?.toInt(),
  contentsUrl: json['contents_url'] as String?,
  deletions: (json['deletions'] as num?)?.toInt(),
  filename: json['filename'] as String?,
  patch: json['patch'] as String?,
  previousFilename: json['previous_filename'] as String?,
  rawUrl: json['raw_url'] as String?,
  sha: json['sha'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$CommitFileToJson(CommitFile instance) =>
    <String, dynamic>{
      'additions': instance.additions,
      'blob_url': instance.blobUrl,
      'changes': instance.changes,
      'contents_url': instance.contentsUrl,
      'deletions': instance.deletions,
      'filename': instance.filename,
      'patch': instance.patch,
      'previous_filename': instance.previousFilename,
      'raw_url': instance.rawUrl,
      'sha': instance.sha,
      'status': instance.status,
    };

CommitParent _$CommitParentFromJson(Map<String, dynamic> json) => CommitParent(
  htmlUrl: json['html_url'] as String?,
  sha: json['sha'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$CommitParentToJson(CommitParent instance) =>
    <String, dynamic>{
      'html_url': instance.htmlUrl,
      'sha': instance.sha,
      'url': instance.url,
    };

CommitStats _$CommitStatsFromJson(Map<String, dynamic> json) => CommitStats(
  additions: (json['additions'] as num?)?.toInt(),
  deletions: (json['deletions'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
);

Map<String, dynamic> _$CommitStatsToJson(CommitStats instance) =>
    <String, dynamic>{
      'additions': instance.additions,
      'deletions': instance.deletions,
      'total': instance.total,
    };
