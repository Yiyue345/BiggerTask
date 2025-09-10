import 'package:json_annotation/json_annotation.dart';
import 'github_user.dart';
import 'repository.dart';

part 'issue.g.dart';

@JsonSerializable()
class Label {
  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final String url;
  final String name;
  final String color;
  final String? description;
  final bool? default_;

  Label({
    required this.id,
    required this.nodeId,
    required this.url,
    required this.name,
    required this.color,
    this.description,
    this.default_,
  });

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
  Map<String, dynamic> toJson() => _$LabelToJson(this);
}

@JsonSerializable()
class Milestone {
  @JsonKey(name: 'closed_at')
  final String? closedAt;
  @JsonKey(name: 'closed_issues')
  final int closedIssues;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final SimpleGitHubUser creator;
  final String description;
  @JsonKey(name: 'due_on')
  final String? dueOn;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final int id;
  @JsonKey(name: 'labels_url')
  final String labelsUrl;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final int number;
  @JsonKey(name: 'open_issues')
  final int openIssues;
  final String state;
  final String title;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final String url;

  Milestone({
    this.closedAt,
    required this.closedIssues,
    required this.createdAt,
    required this.creator,
    required this.description,
    this.dueOn,
    required this.htmlUrl,
    required this.id,
    required this.labelsUrl,
    required this.nodeId,
    required this.number,
    required this.openIssues,
    required this.state,
    required this.title,
    required this.updatedAt,
    required this.url,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) =>
      _$MilestoneFromJson(json);

  Map<String, dynamic> toJson() => _$MilestoneToJson(this);
}

@JsonSerializable()
class PullRequest {
  @JsonKey(name: 'diff_url')
  final String diffUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  @JsonKey(name: 'merged_at')
  final String? mergedAt;
  @JsonKey(name: 'patch_url')
  final String patchUrl;
  final String url;

  PullRequest({
    required this.diffUrl,
    required this.htmlUrl,
    this.mergedAt,
    required this.patchUrl,
    required this.url,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) =>
      _$PullRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PullRequestToJson(this);
}

@JsonSerializable()
class Reactions {
  @JsonKey(name: '+1')
  final int plusOne;
  @JsonKey(name: '-1')
  final int minusOne;
  final int confused;
  final int eyes;
  final int heart;
  final int hooray;
  final int laugh;
  final int rocket;
  @JsonKey(name: 'total_count')
  final int totalCount;
  final String url;

  Reactions({
    required this.plusOne,
    required this.minusOne,
    required this.confused,
    required this.eyes,
    required this.heart,
    required this.hooray,
    required this.laugh,
    required this.rocket,
    required this.totalCount,
    required this.url,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) =>
      _$ReactionsFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionsToJson(this);
}

@JsonSerializable()
class GitHubAppPermissions {
  final String? deployments;
  final String? issues;

  GitHubAppPermissions({
    this.deployments,
    this.issues,
  });

  factory GitHubAppPermissions.fromJson(Map<String, dynamic> json) =>
      _$GitHubAppPermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubAppPermissionsToJson(this);
}

@JsonSerializable()
class GitHubApp {
  @JsonKey(name: 'client_id')
  final String? clientId;
  @JsonKey(name: 'client_secret')
  final String? clientSecret;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String description;
  final List<String> events;
  @JsonKey(name: 'external_url')
  final String externalUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final int id;
  @JsonKey(name: 'installations_count')
  final int installationsCount;
  final String name;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final SimpleGitHubUser owner;
  final String pem;
  final GitHubAppPermissions permissions;
  final String slug;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'webhook_secret')
  final String webhookSecret;

  GitHubApp({
    this.clientId,
    this.clientSecret,
    required this.createdAt,
    required this.description,
    required this.events,
    required this.externalUrl,
    required this.htmlUrl,
    required this.id,
    required this.installationsCount,
    required this.name,
    required this.nodeId,
    required this.owner,
    required this.pem,
    required this.permissions,
    required this.slug,
    required this.updatedAt,
    required this.webhookSecret,
  });

  factory GitHubApp.fromJson(Map<String, dynamic> json) =>
      _$GitHubAppFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubAppToJson(this);
}

@JsonSerializable()
class Issue {
  @JsonKey(name: 'active_lock_reason')
  final String? activeLockReason;
  final SimpleGitHubUser? assignee;
  final List<SimpleGitHubUser>? assignees;
  @JsonKey(name: 'author_association')
  final String authorAssociation;
  final String? body;
  @JsonKey(name: 'body_html')
  final String? bodyHtml;
  @JsonKey(name: 'body_text')
  final String? bodyText;
  @JsonKey(name: 'closed_at')
  final String? closedAt;
  @JsonKey(name: 'closed_by')
  final SimpleGitHubUser? closedBy;
  final int comments;
  @JsonKey(name: 'comments_url')
  final String commentsUrl;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'events_url')
  final String eventsUrl;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final int id;
  final List<Label>? labels;
  @JsonKey(name: 'labels_url')
  final String labelsUrl;
  final bool locked;
  final Milestone? milestone;
  @JsonKey(name: 'node_id')
  final String nodeId;
  final int number;
  @JsonKey(name: 'performed_via_github_app')
  final GitHubApp? performedViaGithubApp;
  @JsonKey(name: 'pull_request')
  final PullRequest? pullRequest;
  final Reactions? reactions;
  final Repository? repository;
  @JsonKey(name: 'repository_url')
  final String repositoryUrl;
  final String state;
  @JsonKey(name: 'timeline_url')
  final String timelineUrl;
  final String title;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final String url;
  final SimpleGitHubUser user;

  Issue({
    this.activeLockReason,
    this.assignee,
    this.assignees,
    required this.authorAssociation,
    this.body,
    this.bodyHtml,
    this.bodyText,
    this.closedAt,
    this.closedBy,
    required this.comments,
    required this.commentsUrl,
    required this.createdAt,
    required this.eventsUrl,
    required this.htmlUrl,
    required this.id,
    this.labels,
    required this.labelsUrl,
    required this.locked,
    this.milestone,
    required this.nodeId,
    required this.number,
    this.performedViaGithubApp,
    this.pullRequest,
    this.reactions,
    this.repository,
    required this.repositoryUrl,
    required this.state,
    required this.timelineUrl,
    required this.title,
    required this.updatedAt,
    required this.url,
    required this.user,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}

@JsonSerializable()
class Comment {
  @JsonKey(name: 'author_association')
  final String authorAssociation;
  final String body;
  @JsonKey(name: 'body_html')
  final String? bodyHtml;
  @JsonKey(name: 'body_text')
  final String? bodyText;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final int id;
  @JsonKey(name: 'issue_url')
  final String issueUrl;
  @JsonKey(name: 'node_id')
  final String nodeId;
  @JsonKey(name: 'performed_via_github_app')
  final GitHubApp? performedViaGithubApp;
  final Reactions? reactions;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final String url;
  final SimpleGitHubUser user;

  Comment({
    required this.authorAssociation,
    required this.body,
    this.bodyHtml,
    this.bodyText,
    required this.createdAt,
    required this.htmlUrl,
    required this.id,
    required this.issueUrl,
    required this.nodeId,
    this.performedViaGithubApp,
    this.reactions,
    required this.updatedAt,
    required this.url,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
