import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final Actor actor;
  @JsonKey(name: 'created_at')
  // 形如 2025-07-07T07:42:56Z
  final String createdAt;
  final String? id;
  final Organization? org;
  final Payload payload;
  final bool? public;
  final EventRepository repo;
  final String? type;

  Event({
    required this.actor,
    required this.createdAt,
    this.id,
    this.org,
    required this.payload,
    this.public,
    required this.repo,
    this.type,
  });

  DateTime get createdDateTime => DateTime.parse(createdAt);
  DateTime get localTime => createdDateTime.toLocal();

  Duration get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(localTime);

    return difference;
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class Actor {
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'display_login')
  final String? displayLogin;
  @JsonKey(name: 'gravatar_id')
  final String gravatarId;
  final int id;
  final String login;
  final String url;

  Actor({
    required this.avatarUrl,
    this.displayLogin,
    required this.gravatarId,
    required this.id,
    required this.login,
    required this.url,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}

@JsonSerializable()
class Organization {
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'display_login')
  final String? displayLogin;
  @JsonKey(name: 'gravatar_id')
  final String? gravatarId;
  final int? id;
  final String? login;
  final String? url;

  Organization({
    this.avatarUrl,
    this.displayLogin,
    this.gravatarId,
    this.id,
    this.login,
    this.url,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class Payload {
  final String? action;
  final Comment? comment;
  final Issue? issue;
  final List<Page>? pages;
  final EventRepository? forkee;
  final String? ref;
  @JsonKey(name: 'ref_type')
  final String? refType;
  @JsonKey(name: 'master_branch')
  final String? masterBranch;
  final String? description;
  @JsonKey(name: 'pusher_type')
  final String? pusherType;
  final Release? release;

  Payload({
    this.action,
    this.comment,
    this.issue,
    this.pages,
    this.forkee,
    this.ref,
    this.refType,
    this.masterBranch,
    this.description,
    this.pusherType,
    this.release
  });

  factory Payload.fromJson(Map<String, dynamic> json) => _$PayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}

@JsonSerializable()
class Comment {
  @JsonKey(name: 'author_association')
  final String? authorAssociation;
  final String? body;
  @JsonKey(name: 'body_html')
  final String? bodyHtml;
  @JsonKey(name: 'body_text')
  final String? bodyText;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final int? id;
  @JsonKey(name: 'issue_url')
  final String? issueUrl;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  @JsonKey(name: 'performed_via_github_app')
  final GitHubApp? performedViaGithubApp;
  final Reactions? reactions;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final String? url;
  final EventUser? user;

  Comment({
    this.authorAssociation,
    this.body,
    this.bodyHtml,
    this.bodyText,
    this.createdAt,
    this.htmlUrl,
    this.id,
    this.issueUrl,
    this.nodeId,
    this.performedViaGithubApp,
    this.reactions,
    this.updatedAt,
    this.url,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class EventRepository {
  final int id;
  final String name;
  final String url;

  EventRepository({
    required this.id,
    required this.name,
    required this.url,
  });

  factory EventRepository.fromJson(Map<String, dynamic> json) => _$EventRepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$EventRepositoryToJson(this);
}

@JsonSerializable()
class GitHubApp {
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final String? description;
  final List<String>? events;
  @JsonKey(name: 'external_url')
  final String? externalUrl;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final int? id;
  @JsonKey(name: 'installations_count')
  final int? installationsCount;
  final String? name;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  final EventUser? owner;
  final String? pem;
  final Map<String, String>? permissions;
  final String? slug;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'webhook_secret')
  final String? webhookSecret;

  GitHubApp({
    this.clientId,
    this.clientSecret,
    this.createdAt,
    this.description,
    this.events,
    this.externalUrl,
    this.htmlUrl,
    this.id,
    this.installationsCount,
    this.name,
    this.nodeId,
    this.owner,
    this.pem,
    this.permissions,
    this.slug,
    this.updatedAt,
    this.webhookSecret,
  });

  factory GitHubApp.fromJson(Map<String, dynamic> json) => _$GitHubAppFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubAppToJson(this);
}

@JsonSerializable()
class Reactions {
  @JsonKey(name: '+1')
  final int? plusOne;
  @JsonKey(name: '-1')
  final int? minusOne;
  final int? confused;
  final int? eyes;
  final int? heart;
  final int? hooray;
  final int? laugh;
  final int? rocket;
  @JsonKey(name: 'total_count')
  final int? totalCount;
  final String? url;

  Reactions({
    this.plusOne,
    this.minusOne,
    this.confused,
    this.eyes,
    this.heart,
    this.hooray,
    this.laugh,
    this.rocket,
    this.totalCount,
    this.url,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) => _$ReactionsFromJson(json);
  Map<String, dynamic> toJson() => _$ReactionsToJson(this);
}

@JsonSerializable()
class Issue {
  @JsonKey(name: 'active_lock_reason')
  final String? activeLockReason;
  final EventUser? assignee;
  final List<EventUser>? assignees;
  @JsonKey(name: 'author_association')
  final String? authorAssociation;
  final String? body;
  @JsonKey(name: 'body_html')
  final String? bodyHtml;
  @JsonKey(name: 'body_text')
  final String? bodyText;
  @JsonKey(name: 'closed_at')
  final String? closedAt;
  final int? comments;
  @JsonKey(name: 'comments_url')
  final String? commentsUrl;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'events_url')
  final String? eventsUrl;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final int? id;
  final List<Label>? labels;
  @JsonKey(name: 'labels_url')
  final String? labelsUrl;
  final bool? locked;
  final Milestone? milestone;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  final int? number;
  @JsonKey(name: 'performed_via_github_app')
  final GitHubApp? performedViaGithubApp;
  @JsonKey(name: 'pull_request')
  final PullRequest? pullRequest;
  final String? state;
  @JsonKey(name: 'timeline_url')
  final String? timelineUrl;
  final String? title;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final String? url;
  final EventUser? user;

  Issue({
    this.activeLockReason,
    this.assignee,
    this.assignees,
    this.authorAssociation,
    this.body,
    this.bodyHtml,
    this.bodyText,
    this.closedAt,
    this.comments,
    this.commentsUrl,
    this.createdAt,
    this.eventsUrl,
    this.htmlUrl,
    this.id,
    this.labels,
    this.labelsUrl,
    this.locked,
    this.milestone,
    this.nodeId,
    this.number,
    this.performedViaGithubApp,
    this.pullRequest,
    this.state,
    this.timelineUrl,
    this.title,
    this.updatedAt,
    this.url,
    this.user,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
  Map<String, dynamic> toJson() => _$IssueToJson(this);
}

@JsonSerializable()
class EventUser {
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'events_url')
  final String eventsUrl;
  @JsonKey(name: 'followers_url')
  final String followersUrl;
  @JsonKey(name: 'following_url')
  final String followingUrl;
  @JsonKey(name: 'gists_url')
  final String gistsUrl;
  @JsonKey(name: 'gravatar_id')
  final String? gravatarId;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final int id;
  final String login;
  @JsonKey(name: 'node_id')
  final String nodeId;
  @JsonKey(name: 'organizations_url')
  final String organizationsUrl;
  @JsonKey(name: 'received_events_url')
  final String receivedEventsUrl;
  @JsonKey(name: 'repos_url')
  final String reposUrl;
  @JsonKey(name: 'site_admin')
  final bool siteAdmin;
  @JsonKey(name: 'starred_at')
  final String? starredAt;
  @JsonKey(name: 'starred_url')
  final String starredUrl;
  @JsonKey(name: 'subscriptions_url')
  final String subscriptionsUrl;
  final String type;
  final String url;

  EventUser({
    required this.avatarUrl,
    required this.eventsUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    this.gravatarId,
    required this.htmlUrl,
    required this.id,
    required this.login,
    required this.nodeId,
    required this.organizationsUrl,
    required this.receivedEventsUrl,
    required this.reposUrl,
    required this.siteAdmin,
    this.starredAt,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.type,
    required this.url,
  });

  factory EventUser.fromJson(Map<String, dynamic> json) => _$EventUserFromJson(json);
  Map<String, dynamic> toJson() => _$EventUserToJson(this);
}

@JsonSerializable()
class Page {
  final String? action;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  @JsonKey(name: 'page_name')
  final String? pageName;
  final String? sha;
  final String? summary;
  final String? title;

  Page({
    this.action,
    this.htmlUrl,
    this.pageName,
    this.sha,
    this.summary,
    this.title,
  });

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);
}

@JsonSerializable()
class Label {
  final String? color;
  final bool? default_;
  final String? description;
  final int? id;
  final String? name;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  final String? url;

  Label({
    this.color,
    this.default_,
    this.description,
    this.id,
    this.name,
    this.nodeId,
    this.url,
  });

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
  Map<String, dynamic> toJson() => _$LabelToJson(this);
}

@JsonSerializable()
class Milestone {
  @JsonKey(name: 'closed_at')
  final String? closedAt;
  @JsonKey(name: 'closed_issues')
  final int? closedIssues;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final EventUser? creator;
  final String? description;
  @JsonKey(name: 'due_on')
  final String? dueOn;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  final int? id;
  @JsonKey(name: 'labels_url')
  final String? labelsUrl;
  @JsonKey(name: 'node_id')
  final String? nodeId;
  final int? number;
  @JsonKey(name: 'open_issues')
  final int? openIssues;
  final String? state;
  final String? title;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final String? url;

  Milestone({
    this.closedAt,
    this.closedIssues,
    this.createdAt,
    this.creator,
    this.description,
    this.dueOn,
    this.htmlUrl,
    this.id,
    this.labelsUrl,
    this.nodeId,
    this.number,
    this.openIssues,
    this.state,
    this.title,
    this.updatedAt,
    this.url,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) => _$MilestoneFromJson(json);
  Map<String, dynamic> toJson() => _$MilestoneToJson(this);
}

@JsonSerializable()
class PullRequest {
  @JsonKey(name: 'diff_url')
  final String? diffUrl;
  @JsonKey(name: 'html_url')
  final String? htmlUrl;
  @JsonKey(name: 'merged_at')
  final String? mergedAt;
  @JsonKey(name: 'patch_url')
  final String? patchUrl;
  final String? url;

  PullRequest({
    this.diffUrl,
    this.htmlUrl,
    this.mergedAt,
    this.patchUrl,
    this.url,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) => _$PullRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PullRequestToJson(this);
}

@JsonSerializable()
class Release {
  final String url;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  @JsonKey(name: 'assets_url')
  final String assetsUrl;
  @JsonKey(name: 'upload_url')
  final String uploadUrl;
  @JsonKey(name: 'tarball_url')
  final String tarballUrl;
  @JsonKey(name: 'zipball_url')
  final String zipballUrl;
  @JsonKey(name: 'discussion_url')
  final String? discussionUrl;
  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  @JsonKey(name: 'tag_name')
  final String tagName;
  @JsonKey(name: 'target_commitish')
  final String targetCommitish;
  final String name;
  final String body;
  final bool draft;
  final bool prerelease;
  final bool immutable;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'published_at')
  final String? publishedAt;
  final EventUser author;
  final List<ReleaseAsset> assets;

  Release({
    required this.url,
    required this.htmlUrl,
    required this.assetsUrl,
    required this.uploadUrl,
    required this.tarballUrl,
    required this.zipballUrl,
    this.discussionUrl,
    required this.id,
    required this.nodeId,
    required this.tagName,
    required this.targetCommitish,
    required this.name,
    required this.body,
    required this.draft,
    required this.prerelease,
    required this.immutable,
    required this.createdAt,
    this.publishedAt,
    required this.author,
    required this.assets,
  });

  // 时间解析方法
  DateTime get createdDateTime => DateTime.parse(createdAt);
  DateTime? get publishedDateTime => publishedAt != null ? DateTime.parse(publishedAt!) : null;

  DateTime get localCreatedTime => createdDateTime.toLocal();
  DateTime? get localPublishedTime => publishedDateTime?.toLocal();

  String get formattedCreatedTime => DateFormat('yyyy-MM-dd HH:mm').format(localCreatedTime);
  String? get formattedPublishedTime => localPublishedTime != null
      ? DateFormat('yyyy-MM-dd HH:mm').format(localPublishedTime!)
      : null;

  factory Release.fromJson(Map<String, dynamic> json) => _$ReleaseFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}

@JsonSerializable()
class ReleaseAsset {
  final String url;
  @JsonKey(name: 'browser_download_url')
  final String browserDownloadUrl;
  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final String name;
  final String? label;
  final String state;
  @JsonKey(name: 'content_type')
  final String contentType;
  final int size;
  final String? digest;
  @JsonKey(name: 'download_count')
  final int downloadCount;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final EventUser uploader;

  ReleaseAsset({
    required this.url,
    required this.browserDownloadUrl,
    required this.id,
    required this.nodeId,
    required this.name,
    this.label,
    required this.state,
    required this.contentType,
    required this.size,
    this.digest,
    required this.downloadCount,
    required this.createdAt,
    required this.updatedAt,
    required this.uploader,
  });

  // 时间解析
  DateTime get createdDateTime => DateTime.parse(createdAt);
  DateTime get updatedDateTime => DateTime.parse(updatedAt);

  // 文件大小格式化
  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    if (size < 1024 * 1024 * 1024) return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  factory ReleaseAsset.fromJson(Map<String, dynamic> json) => _$ReleaseAssetFromJson(json);
  Map<String, dynamic> toJson() => _$ReleaseAssetToJson(this);
}
